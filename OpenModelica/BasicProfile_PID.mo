within ReferenceOM.TransientRuns;

model BasicProfile_PID "Reference basic-profile test model for tuning PID. Compatible with v0.25"
  // This is reference PID-controlled model based on rankine_regeneration_v2.mo.
  // 1. Re_min in hot and avg channel is the point where Nu from Dittus-Boleter becomes 3.66. Not really touch this point durig simulation though.
  // 2. Hot channel configuration was modified to realistic one; surrounded by adjacent graphite blocks and convection. Six blocks with half thickness were considered. The external G in these blocks is: htc(min. value when power is 15%)*2*pi*r*H*block number.
  // 3. Characteristic curves in pumps and blower are quadratic shape with zero gradient at q=0. The shutoff head (when q=0) is doubled to avoid numerical issue when power and flow rates are low.
  // 4. Deaerator is now based on custom deaerator model which has internal water level.
  // 5. PID controlleres are to control he outlet temp, steam temp and pressure, water level in deaerator, and grid frequency.
  //    Grid frequency deviation from demanding signal is an initiating transient trigger.
  //    Water level variation itself in condenser is not significant, but condenser speed controll is really necessary, as 1: to determine single water level conditions in condenser and deaerator, 2: condenser speed down is required to prevent reverse flow through DA->LPTB during low power condition.
  //    PID controllers are based on custom model, where input value is normalized.
  //    The initial value for integrator is (steady-state output)/k, which gives 0 error at initial state. This seems important for numerical stability during the very initial times. Also, reduces false integrator error while reaching equilibrium state.
  //    The tuning parameters are highly based on personal experience. At least we can say that: low value is needed for reactivity PID considering pcm order, and high k is needed for valve PID as it should operate like feedfoward.
  // 6. Grid is modeled with custom grid model which takes external load demand as time-dependent signal. Total generation in grid is same with reference turbine power, representing islanded micro grid case.
  ThermoPower.Water.Flow1DFV2ph economizer_secondary(A = 0.0001337, Dhyd = 13.05e-3, DynamicMomentum = true, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Colebrook, FluidPhaseStart = ThermoPower.Choices.FluidPhase.FluidPhases.Liquid, redeclare model HeatTransfer = ThermoPower.Thermal.HeatTransferFV.DittusBoelter, L = 12.9, N = 10, Nt = 359, dpnom(displayUnit = "kPa") = 176000, e = 0.00015, hstartin = 856795, hstartout = 1559329, noInitialPressure = false, omega = 0.041, pstart(displayUnit = "MPa") = 1.45e7, wnf = 0.5, wnm = 0.1, wnom = 69.08, Kfc = 2) annotation(
    Placement(transformation(origin = {-170, 4}, extent = {{10, 10}, {-10, -10}}, rotation = -90)));
  ThermoPower.Water.Flow1DFV2ph evaporator_secondary(A = 0.0001337, Dhyd = 13.05e-3, DynamicMomentum = true, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Colebrook, FluidPhaseStart = ThermoPower.Choices.FluidPhase.FluidPhases.TwoPhases, redeclare model HeatTransfer = ThermoPower.Thermal.HeatTransferFV.DittusBoelter, L = 10.2, N = 10, Nt = 359, dpnom(displayUnit = "kPa") = 143000, e = 0.00015, hstartin = 1575931, hstartout = 2611643, noInitialPressure = false, omega = 0.041, pstart(displayUnit = "MPa") = 1.44e7, wnf = 0.5, wnm = 0.1, wnom = 69.08, Kfc = 2) annotation(
    Placement(transformation(origin = {-170, 34}, extent = {{10, 10}, {-10, -10}}, rotation = -90)));
  ThermoPower.Water.Flow1DFV2ph superheater_secondary(A = 0.0001337, Dhyd = 13.05e-3, DynamicMomentum = true, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Colebrook, FluidPhaseStart = ThermoPower.Choices.FluidPhase.FluidPhases.Steam, redeclare model HeatTransfer = ThermoPower.Thermal.HeatTransferFV.DittusBoelter, L = 6.9, N = 10, Nt = 359, dpnom(displayUnit = "kPa") = 9e4, e = 0.00015, hstartin = 2660669, hstartout = 3430465, noInitialPressure = false, omega = 0.041, pstart(displayUnit = "MPa") = 1.43e7, wnf = 0.5, wnm = 0.1, wnom = 69.08, Kfc = 2) annotation(
    Placement(transformation(origin = {-170, 64}, extent = {{10, 10}, {-10, -10}}, rotation = -90)));
  ThermoPower.Gas.Flow1DFV economizer_primary(A = 3.06, Dhyd = 19.05e-3, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Kfnom, redeclare model HeatTransfer = ThermoPower.customModel.Models.ZukauskasInLineHTC(pt_OD = 1.5), Kfnom = 27, L = 12.9, redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He, N = 10, Nt = 1, Tstartbar = 650.15, dpnom = 1e5, e = 0.00015, omega = 21.457, pstart(displayUnit = "MPa") = 6e6, wnom = 81.6, wnf = 0.1, wnm = 0.1, DynamicMomentum = true) annotation(
    Placement(transformation(origin = {-268, 4}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  ThermoPower.Gas.Flow1DFV evaporator_primary(A = 3.06, Dhyd = 19.05e-3, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Kfnom, redeclare model HeatTransfer = ThermoPower.customModel.Models.ZukauskasInLineHTC(pt_OD = 1.5), Kfnom = 27, L = 10.2, redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He, N = 10, Nt = 1, Tstartbar = 770.15, dpnom = 1e5, e = 0.00015, omega = 21.457, pstart(displayUnit = "MPa") = 6e6, wnom = 81.6, wnf = 0.1, wnm = 0.1, DynamicMomentum = true) annotation(
    Placement(transformation(origin = {-268, 34}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  ThermoPower.Gas.Flow1DFV superheater_primary(A = 3.06, Dhyd = 19.05e-3, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Kfnom, redeclare model HeatTransfer = ThermoPower.customModel.Models.ZukauskasInLineHTC(pt_OD = 1.5), Kfnom = 27, L = 6.9, redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He, N = 10, Nt = 1, Tstartbar = 1023.15, dpnom = 1e5, e = 0.00015, omega = 21.457, pstart(displayUnit = "MPa") = 6e6, wnom = 81.6, wnf = 0.1, wnm = 0.1, DynamicMomentum = true) annotation(
    Placement(transformation(origin = {-268, 64}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  ThermoPower.Thermal.MetalTubeFV econonmizer_wall(L = 12.9, Nt = 359, Nw = 9, Tstartbar = 623.15, lambda = 22, rext = 19.05e-3/2, rhomcm = 4000000, rint = 13.05e-3/2) annotation(
    Placement(transformation(origin = {-196, 4}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  ThermoPower.Thermal.CounterCurrentFV counterCurrentFV(Nw = 9) annotation(
    Placement(transformation(origin = {-226, 4}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  ThermoPower.Thermal.MetalTubeFV evaporator_wall(L = 10.2, Nt = 359, Nw = 9, Tstartbar = 723.15, lambda = 22, rext = 19.05e-3/2, rhomcm = 4000000, rint = 13.05e-3/2) annotation(
    Placement(transformation(origin = {-196, 34}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  ThermoPower.Thermal.CounterCurrentFV counterCurrentFV1(Nw = 9) annotation(
    Placement(transformation(origin = {-226, 34}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  ThermoPower.Thermal.MetalTubeFV superheater_wall(L = 6.9, Nt = 359, Nw = 9, Tstartbar = 873.15, lambda = 22, rext = 19.05e-3/2, rhomcm = 4000000, rint = 13.05e-3/2) annotation(
    Placement(transformation(origin = {-196, 64}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  ThermoPower.Thermal.CounterCurrentFV counterCurrentFV2(Nw = 9) annotation(
    Placement(transformation(origin = {-226, 64}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  inner ThermoPower.System system(allowFlowReversal = false, initOpt = ThermoPower.Choices.Init.Options.fixedState, fnom = 60) annotation(
    Placement(transformation(origin = {-124, 208}, extent = {{-10, -10}, {10, 10}})));
  ThermoPower.Electrical.Generator generator(Pnom(displayUnit = "MW") = 6.55e7, referenceGenerator = true, fstart = 60, Np = 1) annotation(
    Placement(transformation(origin = {-8, 78}, extent = {{-10, -10}, {10, 10}})));
  ThermoPower.Water.FlowSplit flowSplit annotation(
    Placement(transformation(origin = {-85, 65}, extent = {{-5, 5}, {5, -5}}, rotation = -90)));
  ThermoPower.Water.Pump CdPump(dp0(displayUnit = "MPa") = 1.41e6, redeclare function efficiencyCharacteristic = ThermoPower.Functions.PumpCharacteristics.constantEfficiency(eta_nom = 0.85), redeclare function flowCharacteristic = ThermoPower.Functions.PumpCharacteristics.quadraticFlow(head_nom = {300.72743947238007, 146.23388533741434, 105.87333298428797}, q_nom = {0, 0.054870609296703905, 0.07133179208571508}), hstart = 193516, n0 = 1800, rho0(displayUnit = "kg/m3") = 983.13, w0 = 54.008, use_in_n = true) annotation(
    Placement(transformation(origin = {-34, 8}, extent = {{10, -10}, {-10, 10}})));
  ThermoPower.Water.Pump FwPump(dp0(displayUnit = "MPa") = 1.3312e7, redeclare function efficiencyCharacteristic = ThermoPower.Functions.PumpCharacteristics.constantEfficiency(eta_nom = 0.85), redeclare function flowCharacteristic = ThermoPower.Functions.PumpCharacteristics.quadraticFlow(head_nom = {3085.5366742612923, 1561.0976244723518, 1130.2346801179826}, q_nom = {0, 0.07947880436649801, 0.10332244567644742}), hstart = 856795, n0 = 1800, rho0(displayUnit = "kg/m3") = 869.24, w0 = 69.08, use_in_n = true) annotation(
    Placement(transformation(origin = {-130, -34}, extent = {{10, -10}, {-10, 10}})));
  ThermoPower.Gas.Flow1DFV hotDuct(A = 0.78, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Kfnom, L = 5, redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He, N = 5, Nt = 1, Tstartbar = 1023.15, dpnom(displayUnit = "Pa") = 3000, e = 0.00015, omega = 1*3.14, pstart(displayUnit = "MPa") = 6e6, wnom = 81.6, wnf = 0.5, wnm = 0.1, Dhyd = 1, Kfnom = 2, DynamicMomentum = true) annotation(
    Placement(transformation(origin = {-328, 16}, extent = {{-10, -10}, {10, 10}})));
  ThermoPower.Gas.Flow1DFV Channel_Avg(A = 2e-4, Dhyd = 1.6e-2, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Colebrook, L = 8, redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He, N = 21, Nt = 3274, Tstartbar = 823.15, dpnom = 1e5, e = 0.00015, omega = 1.6e-2*3.14, pstart(displayUnit = "MPa") = 6e6, wnom = 81.6*3274/3275, wnf = 0.5, wnm = 0.1, Tstartin = 598.15, Tstartout = 1023.15, redeclare model HeatTransfer = ThermoPower.Thermal.HeatTransferFV.DittusBoelter(Re_min = 700), noInitialPressure = true, DynamicMomentum = true) annotation(
    Placement(transformation(origin = {-368, 42}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  ThermoPower.customModel.Models.RadialConduction1D Fuel_mixture_Avg(L = 8, Nr = 5, Nt = 3274, Nw = 20, Tstartbar = 1023.15, lambda = 23.24, rext = 38e-3/2, rhomcm = 2341.42*1800, rint = 25.3e-3/2, useExternalHeatGen = true, useHeatGen = true, axialProfile = {0.04278298, 0.05092866, 0.05695018, 0.06107518, 0.06352006, 0.06449002, 0.06417902, 0.06276982, 0.06043394, 0.0573317, 0.05361218, 0.04941327, 0.04486162, 0.04007265, 0.03515058, 0.03018841, 0.02526791, 0.02045963, 0.01582291, 0.01140586}) annotation(
    Placement(transformation(origin = {-334, 42}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
  ThermoPower.Gas.Flow1DFV coldDuct(A = 0.78, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Kfnom, L = 5, redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He, N = 5, Nt = 1, Tstartbar = 598.15, dpnom(displayUnit = "Pa") = 3000, e = 0.00015, omega = 0.41*3.14, pstart(displayUnit = "MPa") = 6e6, wnom = 81.6, wnf = 0.5, wnm = 0.1, Dhyd = 0.41, Kfnom = 2, noInitialPressure = true, DynamicMomentum = true) annotation(
    Placement(transformation(origin = {-328, -4}, extent = {{10, -10}, {-10, 10}})));
  ThermoPower.customModel.Models.Fan Blower(redeclare function efficiencyCharacteristic = ThermoPower.Functions.PumpCharacteristics.constantEfficiency(eta_nom = 0.85), rho0(displayUnit = "kg/m3") = 4.77, n0 = 1800, w0 = 81.6, dp0(displayUnit = "Pa") = 1.8e5, redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He, redeclare function flowCharacteristic = ThermoPower.Functions.FanCharacteristics.quadraticFlow(H_nom = {64854.44254405128, 37753.17324575091, 27333.29742992366}, q_nom = {0, 17.11477187140708, 22.249203432829205}), use_in_n = true) annotation(
    Placement(transformation(origin = {-302, -12}, extent = {{10, -10}, {-10, 10}})));
  ThermoPower.customModel.Models.RadialConduction1D Graphite_Avg(L = 8, Nr = 5, Nt = 3274, Nw = 20, Tstartbar = 1023.15, lambda = 23.6, rext = 25.3e-3/2, rhomcm = 1780*1979.2, rint = 16e-3/2, useExternalHeatGen = false, useHeatGen = false) annotation(
    Placement(transformation(origin = {-352, 42}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
  ThermoPower.Gas.Header lowerPlenum(redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He, Tmstart = 598.15, V = 62.59, pstart(displayUnit = "MPa") = 6e6, Tstart = 598.15) annotation(
    Placement(transformation(origin = {-458, 4}, extent = {{10, -10}, {-10, 10}})));
  ThermoPower.Gas.Header upperPlenum(redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He, Tmstart = 598.15, Tstart = 598.15, V = 53.88, pstart(displayUnit = "MPa") = 6e6) annotation(
    Placement(transformation(origin = {-422, 102}, extent = {{-10, -10}, {10, 10}})));
  ThermoPower.Electrical.PowerSensor sens_power annotation(
    Placement(transformation(origin = {24, 78}, extent = {{-10, 10}, {10, -10}})));
  ThermoPower.Gas.Flow1DFV Channel_Hot(A = 2e-4, Dhyd = 1.6e-2, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Colebrook, redeclare model HeatTransfer = ThermoPower.Thermal.HeatTransferFV.DittusBoelter(Re_min = 700), L = 8, redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He, N = 21, Nt = 1, Tstartbar = 823.15, Tstartin = 598.15, Tstartout = 1023.15, dpnom = 1e5, e = 0.00015, omega = 1.6e-2*3.14, pstart(displayUnit = "MPa") = 6e6, wnf = 0.5, wnm = 0.1, wnom = 81.6*1/3275, DynamicMomentum = true) annotation(
    Placement(transformation(origin = {-394, 42}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
  ThermoPower.customModel.Models.RadialConduction1D Fuel_mixture_Hot(L = 8, Nr = 5, Nt = 1, Nw = 20, Tstartbar = 1023.15, axialProfile = {0.04278298, 0.05092866, 0.05695018, 0.06107518, 0.06352006, 0.06449002, 0.06417902, 0.06276982, 0.06043394, 0.0573317, 0.05361218, 0.04941327, 0.04486162, 0.04007265, 0.03515058, 0.03018841, 0.02526791, 0.02045963, 0.01582291, 0.01140586}, lambda = 23.24, rext = 38e-3/2, rhomcm = 2341.42*1800, rint = 25.3e-3/2, useExternalHeatGen = true, useHeatGen = true) annotation(
    Placement(transformation(origin = {-426, 42}, extent = {{10, 10}, {-10, -10}}, rotation = 90)));
  ThermoPower.customModel.Models.RadialConduction1D Graphite_Hot(L = 8, Nr = 5, Nt = 1, Nw = 20, Tstartbar = 1023.15, lambda = 23.6, rext = 25.3e-3/2, rhomcm = 1780*1979.2, rint = 16e-3/2, useExternalHeatGen = false, useHeatGen = false) annotation(
    Placement(transformation(origin = {-410, 42}, extent = {{10, 10}, {-10, -10}}, rotation = 90)));
  ThermoPower.Water.ValveVap valve_turbine(CvData = ThermoPower.Choices.Valve.CvTypes.OpPoint, useThetaInput = true, theta_fix = 0.85, pnom(displayUnit = "Pa") = 1.43e7, dpnom(displayUnit = "Pa") = 5e5, wnom = 69.08, rhonom(displayUnit = "kg/m3") = 41.35, thetanom = 0.85, redeclare function FlowChar = ThermoPower.Functions.ValveCharacteristics.quadratic) annotation(
    Placement(transformation(origin = {-153, 85}, extent = {{-5, -5}, {5, 5}})));
  ThermoPower.Water.ValveVap valve_extraction(CvData = ThermoPower.Choices.Valve.CvTypes.OpPoint, dpnom(displayUnit = "Pa") = 143000, pnom(displayUnit = "Pa") = 1.573e6, rhonom(displayUnit = "kg/m3") = 6.719, theta_fix = 0.5, thetanom = 0.5, useThetaInput = false, wnom = 15.079, redeclare function FlowChar = ThermoPower.Functions.ValveCharacteristics.quadratic) annotation(
    Placement(transformation(origin = {-87, 33}, extent = {{-5, 5}, {5, -5}}, rotation = -90)));
  ThermoPower.customModel.Models.ReactorPower reactorPower_Avg(P0 = 180e6/(3274 + 1.59)*3274, Tf0 = 943, Tm0 = 926, alpha_f = -4.2e-5, alpha_m = -8.55e-5, usePKE = true, useRhoExt = true, useTc = false, useTf = true, useTm = true, useXe = true) annotation(
    Placement(transformation(origin = {-336, 100}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Constant signal_constant(k = 1) annotation(
    Placement(transformation(origin = {-234, 214}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  ThermoPower.Gas.SensT1 sens_T_He(redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He) annotation(
    Placement(transformation(origin = {-268, 128}, extent = {{10, -10}, {-10, 10}})));
  ThermoPower.customModel.Blocks.LimPID_Tinit PID_reactivity(Ti = 50, controllerType = Modelica.Blocks.Types.SimpleController.PI, initType = Modelica.Blocks.Types.InitPID.InitialState, k = 0.5, u_m_nom = 1023, useInitTime = false, xi_start = 0/0.003, yMax = 50e-3, yMin = -50e-3, y_start = 0) annotation(
    Placement(transformation(origin = {-302, 134}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
  Modelica.Blocks.Math.Gain Gain_HotChannel(k = 1.59/3274) annotation(
    Placement(transformation(origin = {-384, 132}, extent = {{10, 10}, {-10, -10}})));
  ThermoPower.Water.SensP sens_P_steam annotation(
    Placement(transformation(origin = {-170, 110}, extent = {{10, -10}, {-10, 10}})));
  ThermoPower.customModel.Blocks.LimPID_Tinit PID_blower(Ti = 35, controllerType = Modelica.Blocks.Types.SimpleController.PI, initType = Modelica.Blocks.Types.InitPID.InitialState, k = 1.5, u_m_nom = 14.3e6, useInitTime = false, xi_start = 1/1.5, yMax = 1.2, yMin = 0.1, y_start = 1) annotation(
    Placement(transformation(origin = {-196, 140}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Blocks.Math.Gain Gain_blower(k = 1800) annotation(
    Placement(transformation(origin = {-234, 140}, extent = {{10, 10}, {-10, -10}})));
  ThermoPower.Water.SensT1 sens_T_steam annotation(
    Placement(transformation(origin = {-144, 110}, extent = {{-10, -10}, {10, 10}})));
  ThermoPower.customModel.Blocks.LimPID_Tinit PID_fwpp(Ti = 35, controllerType = Modelica.Blocks.Types.SimpleController.PI, initType = Modelica.Blocks.Types.InitPID.InitialState, k = 1.5, u_s_nom = 823, useInitTime = false, xi_start = 1/1.5, yMax = 1.2, yMin = 0.1, y_start = 1) annotation(
    Placement(transformation(origin = {-112, 116}, extent = {{-10, 10}, {10, -10}})));
  Modelica.Blocks.Math.Gain Gain_fwpp(k = 1800) annotation(
    Placement(transformation(origin = {-76, 116}, extent = {{10, -10}, {-10, 10}}, rotation = -180)));
  ThermoPower.customModel.Models.Deaerator Deaerator(V = 25, pstart(displayUnit = "MPa") = 1.43e6) annotation(
    Placement(transformation(origin = {-78, -2}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
  ThermoPower.customModel.Blocks.LimPID_Tinit PID_cdpp(Ti = 50, controllerType = Modelica.Blocks.Types.SimpleController.PI, initType = Modelica.Blocks.Types.InitPID.InitialState, k = 3.4, u_m_nom = 0.85, useInitTime = false, xi_start = 1/3.4, yMax = 1.2, yMin = 0.1, y_start = 1) annotation(
    Placement(transformation(origin = {2, -20}, extent = {{10, 10}, {-10, -10}})));
  Modelica.Blocks.Math.Gain Gain_cdpp(k = 1800) annotation(
    Placement(transformation(origin = {-32, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  ThermoPower.customModel.Models.SteamTurbineStodolaEta HPTB(Kt = 0.00296, PRstart = 8.773, eta_iso_nom = 0.85, pnom(displayUnit = "MPa") = 1.38e7, useMflowCorrection = true, useWetnessCorrection = true, wnom = 69.08) annotation(
    Placement(transformation(origin = {-114, 78}, extent = {{-10, -10}, {10, 10}})));
  ThermoPower.customModel.Models.SteamTurbineStodolaEta LPTB(Kt = 0.01661, PRstart = 78.65, eta_iso_nom = 0.85, pnom(displayUnit = "MPa") = 1.573e6, useMflowCorrection = true, useWetnessCorrection = true, wnom = 54.008) annotation(
    Placement(transformation(origin = {-62, 78}, extent = {{-10, -10}, {10, 10}})));
  ThermoPower.customModel.Models.Grid_v grid_v(Pgrid(displayUnit = "W") = 65.5e6, pset_const = 65.5e6, use_in_pset = true) annotation(
    Placement(transformation(origin = {68, 78}, extent = {{-10, -10}, {10, 10}})));
  ThermoPower.customModel.Blocks.LimPID_Tinit PID_valve(Ti = 30, controllerType = Modelica.Blocks.Types.SimpleController.PI, initType = Modelica.Blocks.Types.InitPID.InitialState, k = 75, u_m_nom = 60, useInitTime = false, xi_start = 0.85/75, yMax = 1, yMin = 0.05, y_start = 1) annotation(
    Placement(transformation(origin = {60, 148}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Blocks.Math.Gain gain(k = 65.5e6) annotation(
    Placement(transformation(origin = {102, 94}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Modelica.Blocks.Sources.Ramp ramp3(duration = 1020, height = -0.85, offset = 1, startTime = 5100) annotation(
    Placement(transformation(origin = {216, 150}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Blocks.Logical.Switch LoadDemand annotation(
    Placement(transformation(origin = {168, 114}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y = time < 5100 + 1020) annotation(
    Placement(transformation(origin = {216, 114}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Blocks.Sources.Ramp ramp1(duration = 1020, height = 0.85, offset = 0.15, startTime = 5100 + 1020 + 1200) annotation(
    Placement(transformation(origin = {216, 86}, extent = {{10, -10}, {-10, 10}})));
  ThermoPower.Electrical.FrequencySensor sens_frequency annotation(
    Placement(transformation(origin = {60, 108}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  ThermoPower.Gas.Flow1DFV riser(A = 3.74, Dhyd = 0.54, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Kfnom, Kfnom = 2, L = 8, redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He, N = 5, Nt = 1, Tstartbar = 598.15, dpnom(displayUnit = "Pa") = 3000, e = 0.00015, omega = 0.54*3.14, pstart(displayUnit = "MPa") = 6e6, wnf = 0.5, wnm = 0.1, wnom = 81.6, noInitialPressure = true, DynamicMomentum = true) annotation(
    Placement(transformation(origin = {-482, 44}, extent = {{10, 10}, {-10, -10}}, rotation = -90)));
  Modelica.Blocks.Continuous.Derivative RhoDerivative(T = 0.1, initType = Modelica.Blocks.Types.Init.InitialState)  annotation(
    Placement(transformation(origin = {-354, 172}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  ThermoPower.customModel.Models.RadialConduction1D Graphite_Hot_Adjacent(L = 8, Nr = 5, Nt = 6, Nw = 20, Tstartbar = 1023.15, lambda = 23.6, rext = 38e-3/2*2, rhomcm = 1780*1979.2, rint = 38e-3/2, useExternalHeatGen = false, useHeatGen = false) annotation(
    Placement(transformation(origin = {-444, 42}, extent = {{10, 10}, {-10, -10}}, rotation = 90)));
  ThermoPower.Thermal.ConvHTFV conv_adjacent(Nv = 20, G = 430*(2*3.14*16e-3/2*8)*6)  annotation(
    Placement(transformation(origin = {-414, -16}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  ThermoPower.Thermal.TempSource1DFV tempSource1DFV(Nw = 20)  annotation(
    Placement(transformation(origin = {-394, -16}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Sources.Constant AvgTemp_constant(k = 1023) annotation(
    Placement(transformation(origin = {-366, -16}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  ThermoPower.customModel.Models.Condenser_ACC Condenser(cm = 500, condExchSurface = 4802.84, condNomFlowRate = 54.008, condNomPressure(displayUnit = "kPa") = 2e4, condVol = 26.415, coolExchSurface = 105837, coolNomFlowRate = 7433.86, coolNomPressure = 1e5, coolVol = 4157, gamma_cond = 15e3, gamma_cool = 42, metalVol = 141, pstart_cond(displayUnit = "kPa") = 2e4, rhoMetal(displayUnit = "kg/m3") = 8000) annotation(
    Placement(transformation(origin = {24, 32}, extent = {{-10, -10}, {10, 10}})));
  ThermoPower.Gas.SourceMassFlow sourceMassFlow(redeclare package Medium = Modelica.Media.Air.SimpleAir, T = 298.15, p0 = 1e5, w0 = 7433.86) annotation(
    Placement(transformation(origin = {60, 18}, extent = {{10, -10}, {-10, 10}})));
  ThermoPower.Gas.SinkPressure sinkPressure(redeclare package Medium = Modelica.Media.Air.SimpleAir, T = 313.15, p0 = 1e5) annotation(
    Placement(transformation(origin = {60, 44}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(economizer_secondary.outfl, evaporator_secondary.infl) annotation(
    Line(points = {{-170, 14}, {-170, 24}}, color = {0, 0, 255}));
  connect(evaporator_secondary.outfl, superheater_secondary.infl) annotation(
    Line(points = {{-170, 44}, {-170, 54}}, color = {0, 0, 255}));
  connect(counterCurrentFV.side1, econonmizer_wall.ext) annotation(
    Line(points = {{-223, 4}, {-199, 4}}, color = {255, 127, 0}));
  connect(economizer_primary.wall, counterCurrentFV.side2) annotation(
    Line(points = {{-263, 4}, {-229, 4}}, color = {255, 127, 0}));
  connect(econonmizer_wall.int, economizer_secondary.wall) annotation(
    Line(points = {{-193, 4}, {-174, 4}}, color = {255, 127, 0}));
  connect(counterCurrentFV1.side1, evaporator_wall.ext) annotation(
    Line(points = {{-223, 34}, {-199, 34}}, color = {255, 127, 0}));
  connect(counterCurrentFV2.side1, superheater_wall.ext) annotation(
    Line(points = {{-223, 64}, {-199, 64}}, color = {255, 127, 0}));
  connect(evaporator_primary.wall, counterCurrentFV1.side2) annotation(
    Line(points = {{-263, 34}, {-229, 34}}, color = {255, 127, 0}));
  connect(evaporator_wall.int, evaporator_secondary.wall) annotation(
    Line(points = {{-193, 34}, {-175, 34}}, color = {255, 127, 0}));
  connect(superheater_primary.wall, counterCurrentFV2.side2) annotation(
    Line(points = {{-263, 64}, {-229, 64}}, color = {255, 127, 0}));
  connect(superheater_wall.int, superheater_secondary.wall) annotation(
    Line(points = {{-193, 64}, {-175, 64}}, color = {255, 127, 0}));
  connect(superheater_primary.outfl, evaporator_primary.infl) annotation(
    Line(points = {{-268, 54}, {-268, 44}}, color = {159, 159, 223}));
  connect(evaporator_primary.outfl, economizer_primary.infl) annotation(
    Line(points = {{-268, 24}, {-268, 14}}, color = {159, 159, 223}));
  connect(Graphite_Avg.int, Channel_Avg.wall) annotation(
    Line(points = {{-355, 42}, {-363, 42}}, color = {255, 127, 0}));
  connect(Fuel_mixture_Avg.int, Graphite_Avg.ext) annotation(
    Line(points = {{-337, 42}, {-349, 42}}, color = {255, 127, 0}));
  connect(Blower.infl, economizer_primary.outfl) annotation(
    Line(points = {{-294, -10}, {-294, -6}, {-268, -6}}, color = {159, 159, 223}));
  connect(coldDuct.infl, Blower.outfl) annotation(
    Line(points = {{-318, -4}, {-318, -5}, {-308, -5}}, color = {159, 159, 223}));
  connect(hotDuct.outfl, superheater_primary.infl) annotation(
    Line(points = {{-318, 16}, {-296, 16}, {-296, 90}, {-268, 90}, {-268, 74}}, color = {159, 159, 223}));
  connect(coldDuct.outfl, lowerPlenum.inlet) annotation(
    Line(points = {{-338, -4}, {-358, -4}, {-358, 4}, {-448, 4}}, color = {159, 159, 223}));
  connect(economizer_secondary.infl, FwPump.outfl) annotation(
    Line(points = {{-170, -6}, {-168, -6}, {-168, -27}, {-136, -27}}, color = {0, 0, 255}));
  connect(generator.port, sens_power.port_a) annotation(
    Line(points = {{1, 78}, {14, 78}}, color = {0, 0, 255}));
  connect(Fuel_mixture_Hot.int, Graphite_Hot.ext) annotation(
    Line(points = {{-422, 42}, {-413, 42}}, color = {255, 127, 0}));
  connect(Graphite_Hot.int, Channel_Hot.wall) annotation(
    Line(points = {{-407, 42}, {-398, 42}}, color = {255, 127, 0}));
  connect(upperPlenum.outlet, Channel_Hot.infl) annotation(
    Line(points = {{-412, 102}, {-394, 102}, {-394, 52}}, color = {159, 159, 223}));
  connect(upperPlenum.outlet, Channel_Avg.infl) annotation(
    Line(points = {{-412, 102}, {-368, 102}, {-368, 52}}, color = {159, 159, 223}));
  connect(Channel_Avg.outfl, hotDuct.infl) annotation(
    Line(points = {{-368, 32}, {-368, 16}, {-338, 16}}, color = {159, 159, 223}));
  connect(Channel_Hot.outfl, hotDuct.infl) annotation(
    Line(points = {{-394, 32}, {-394, 16}, {-338, 16}}, color = {159, 159, 223}));
  connect(superheater_secondary.outfl, valve_turbine.inlet) annotation(
    Line(points = {{-170, 74}, {-170, 85}, {-158, 85}}, color = {0, 0, 255}));
  connect(flowSplit.out1, valve_extraction.inlet) annotation(
    Line(points = {{-87, 62}, {-87, 38}}, color = {0, 0, 255}));
  connect(superheater_primary.infl, sens_T_He.flange) annotation(
    Line(points = {{-268, 74}, {-268, 124}}, color = {159, 159, 223}));
  connect(sens_T_He.T, PID_reactivity.u_m) annotation(
    Line(points = {{-274, 134}, {-290, 134}}, color = {0, 0, 127}));
  connect(signal_constant.y, PID_reactivity.u_s) annotation(
    Line(points = {{-234, 204}, {-234, 176}, {-302, 176}, {-302, 146}}, color = {0, 0, 127}));
  connect(PID_reactivity.y, reactorPower_Avg.rho_ext) annotation(
    Line(points = {{-302, 123}, {-302, 114}, {-360, 114}, {-360, 100}, {-344, 100}}, color = {0, 0, 127}));
  connect(Fuel_mixture_Avg.Tm_avg, reactorPower_Avg.Tf) annotation(
    Line(points = {{-336, 52}, {-342, 52}, {-342, 92}}, color = {0, 0, 127}));
  connect(Graphite_Avg.Tm_avg, reactorPower_Avg.Tm) annotation(
    Line(points = {{-354, 52}, {-354, 70}, {-336, 70}, {-336, 92}}, color = {0, 0, 127}));
  connect(reactorPower_Avg.Power, Fuel_mixture_Avg.heatGenInput) annotation(
    Line(points = {{-326, 100}, {-316, 100}, {-316, 64}, {-332, 64}, {-332, 52}}, color = {0, 0, 127}));
  connect(reactorPower_Avg.Power, Gain_HotChannel.u) annotation(
    Line(points = {{-326, 100}, {-324, 100}, {-324, 132}, {-372, 132}}, color = {0, 0, 127}));
  connect(Gain_HotChannel.y, Fuel_mixture_Hot.heatGenInput) annotation(
    Line(points = {{-394, 132}, {-456, 132}, {-456, 66}, {-428, 66}, {-428, 52}}, color = {0, 0, 127}));
  connect(superheater_secondary.outfl, sens_P_steam.flange) annotation(
    Line(points = {{-170, 74}, {-170, 106}}, color = {0, 0, 255}));
  connect(sens_P_steam.p, PID_blower.u_m) annotation(
    Line(points = {{-178, 116}, {-196, 116}, {-196, 128}}, color = {0, 0, 127}));
  connect(signal_constant.y, PID_blower.u_s) annotation(
    Line(points = {{-234, 204}, {-234, 176}, {-172, 176}, {-172, 140}, {-184, 140}}, color = {0, 0, 127}));
  connect(PID_blower.y, Gain_blower.u) annotation(
    Line(points = {{-206, 140}, {-222, 140}}, color = {0, 0, 127}));
  connect(Gain_blower.y, Blower.in_n) annotation(
    Line(points = {{-244, 140}, {-250, 140}, {-250, 98}, {-302, 98}, {-302, -4}}, color = {0, 0, 127}));
  connect(superheater_secondary.outfl, sens_T_steam.flange) annotation(
    Line(points = {{-170, 74}, {-170, 94}, {-144, 94}, {-144, 106}}, color = {0, 0, 255}));
  connect(sens_T_steam.T, PID_fwpp.u_s) annotation(
    Line(points = {{-136, 116}, {-124, 116}}, color = {0, 0, 127}));
  connect(signal_constant.y, PID_fwpp.u_m) annotation(
    Line(points = {{-234, 204}, {-234, 176}, {-112, 176}, {-112, 128}}, color = {0, 0, 127}));
  connect(PID_fwpp.y, Gain_fwpp.u) annotation(
    Line(points = {{-100, 116}, {-88, 116}}, color = {0, 0, 127}));
  connect(Gain_fwpp.y, FwPump.in_n) annotation(
    Line(points = {{-64, 116}, {-40, 116}, {-40, 50}, {-128, 50}, {-128, -26}}, color = {0, 0, 127}));
  connect(valve_extraction.outlet, Deaerator.SteamIn) annotation(
    Line(points = {{-87, 28}, {-84, 28}, {-84, 6}}, color = {0, 0, 255}));
  connect(CdPump.outfl, Deaerator.WaterIn) annotation(
    Line(points = {{-40, 16}, {-42, 16}, {-42, 26}, {-72, 26}, {-72, 6}}, color = {0, 0, 255}));
  connect(Deaerator.CondOut, FwPump.infl) annotation(
    Line(points = {{-78, -12}, {-78, -32}, {-122, -32}}, color = {0, 0, 255}));
  connect(signal_constant.y, PID_cdpp.u_s) annotation(
    Line(points = {{-234, 204}, {-234, 176}, {124, 176}, {124, -20}, {14, -20}}, color = {0, 0, 127}));
  connect(PID_cdpp.y, Gain_cdpp.u) annotation(
    Line(points = {{-8, -20}, {-20, -20}}, color = {0, 0, 127}));
  connect(Gain_cdpp.y, CdPump.in_n) annotation(
    Line(points = {{-42, -20}, {-56, -20}, {-56, 30}, {-32, 30}, {-32, 16}}, color = {0, 0, 127}));
  connect(valve_turbine.outlet, HPTB.inlet) annotation(
    Line(points = {{-148, 85}, {-135, 85}, {-135, 86}, {-122, 86}}, color = {0, 0, 255}));
  connect(HPTB.outlet, flowSplit.in1) annotation(
    Line(points = {{-106, 86}, {-106, 68}, {-84, 68}}, color = {0, 0, 255}));
  connect(flowSplit.out2, LPTB.inlet) annotation(
    Line(points = {{-82, 62}, {-76, 62}, {-76, 86}, {-70, 86}}, color = {0, 0, 255}));
  connect(HPTB.shaft_b, LPTB.shaft_a) annotation(
    Line(points = {{-108, 78}, {-69, 78}}));
  connect(LPTB.shaft_b, generator.shaft) annotation(
    Line(points = {{-56, 78}, {-16, 78}}));
  connect(grid_v.port, sens_power.port_b) annotation(
    Line(points = {{59, 78}, {34, 78}}, color = {0, 0, 255}));
  connect(PID_valve.y, valve_turbine.theta) annotation(
    Line(points = {{49, 148}, {-26, 148}, {-26, 92}, {-152, 92}, {-152, 90}}, color = {0, 0, 127}));
  connect(gain.y, grid_v.pset) annotation(
    Line(points = {{92, 94}, {65, 94}, {65, 86}}, color = {0, 0, 127}));
  connect(ramp3.y, LoadDemand.u1) annotation(
    Line(points = {{205, 150}, {192, 150}, {192, 122}, {180, 122}}, color = {0, 0, 127}));
  connect(booleanExpression.y, LoadDemand.u2) annotation(
    Line(points = {{205, 114}, {180, 114}}, color = {255, 0, 255}));
  connect(ramp1.y, LoadDemand.u3) annotation(
    Line(points = {{205, 86}, {193, 86}, {193, 106}, {179, 106}}, color = {0, 0, 127}));
  connect(LoadDemand.y, gain.u) annotation(
    Line(points = {{157, 114}, {146, 114}, {146, 94}, {114, 94}}, color = {0, 0, 127}));
  connect(grid_v.port, sens_frequency.port) annotation(
    Line(points = {{60, 78}, {60, 98}}, color = {0, 0, 255}));
  connect(signal_constant.y, PID_valve.u_s) annotation(
    Line(points = {{-234, 204}, {-234, 176}, {92, 176}, {92, 148}, {72, 148}}, color = {0, 0, 127}));
  connect(sens_frequency.f, PID_valve.u_m) annotation(
    Line(points = {{60, 118}, {60, 136}}, color = {0, 0, 127}));
  connect(lowerPlenum.outlet, riser.infl) annotation(
    Line(points = {{-468, 4}, {-482, 4}, {-482, 34}}, color = {159, 159, 223}));
  connect(riser.outfl, upperPlenum.inlet) annotation(
    Line(points = {{-482, 54}, {-480, 54}, {-480, 102}, {-432, 102}}, color = {159, 159, 223}));
  connect(PID_reactivity.y, RhoDerivative.u) annotation(
    Line(points = {{-302, 124}, {-302, 114}, {-332, 114}, {-332, 172}, {-342, 172}}, color = {0, 0, 127}));
  connect(Graphite_Hot_Adjacent.int, Fuel_mixture_Hot.ext) annotation(
    Line(points = {{-440, 42}, {-430, 42}}, color = {255, 127, 0}));
  connect(Graphite_Hot_Adjacent.ext, conv_adjacent.side2) annotation(
    Line(points = {{-448, 42}, {-460, 42}, {-460, 16}, {-430, 16}, {-430, -16}, {-418, -16}}, color = {255, 127, 0}));
  connect(tempSource1DFV.wall, conv_adjacent.side1) annotation(
    Line(points = {{-396, -16}, {-410, -16}}, color = {255, 127, 0}));
  connect(AvgTemp_constant.y, tempSource1DFV.temperature) annotation(
    Line(points = {{-376, -16}, {-390, -16}}, color = {0, 0, 127}));
  connect(LPTB.outlet, Condenser.steamIn) annotation(
    Line(points = {{-54, 86}, {8, 86}, {8, 54}, {24, 54}, {24, 42}}, color = {0, 0, 255}));
  connect(sourceMassFlow.flange, Condenser.coolingIn) annotation(
    Line(points = {{50, 18}, {42, 18}, {42, 28}, {34, 28}}, color = {159, 159, 223}));
  connect(Condenser.coolingOut, sinkPressure.flange) annotation(
    Line(points = {{34, 38}, {40, 38}, {40, 44}, {50, 44}}, color = {159, 159, 223}));
  connect(Condenser.waterOut, CdPump.infl) annotation(
    Line(points = {{24, 22}, {24, 10}, {-26, 10}}, color = {0, 0, 255}));
  connect(Condenser.ratio_VvonVtot, PID_cdpp.u_m) annotation(
    Line(points = {{14, 34}, {2, 34}, {2, -8}}, color = {0, 0, 127}));
  annotation(
    experiment(StartTime = 0, StopTime = 10000, Tolerance = 1e-06, Interval = 5),
    Diagram(coordinateSystem(extent = {{-500, 140}, {100, -60}})),
    Documentation(info = "<HTML>
<b>Ramp Profile</b><p>
<Li>Equilibrium up to 5000s
<Li>Maintain steady-state for 100 s
<Li>Ramp down to 15% at a rate of 5%/min
<Li>Maintain 15% for 20 min
<Li>Ramp up to 100% at a rate of 5%/min
<Li>Maintain 100% for the rest
</ul>
</html>"));
end BasicProfile_PID;