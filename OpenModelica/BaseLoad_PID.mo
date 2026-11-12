within ReferenceOM.TransientRuns;

model BaseLoad_PID "Reference base load model with PID controller. Compatible with v0.25"
  //-------------------- Steam geneartor part ----------------------//
  //-------------------- Turbomachinery components ----------------------//
  //-------------------- Primary helium loops ----------------------//
  Modelica.Blocks.Sources.Ramp ramp31(duration = 1020, height = -0.8357, offset = 1, startTime = 1000) annotation(
    Placement(transformation(origin = {134, 88}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Blocks.Logical.Switch LoadDemand annotation(
    Placement(transformation(origin = {86, 52}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression1(y = time < 5000) annotation(
    Placement(transformation(origin = {134, 52}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Blocks.Sources.CombiTimeTable BaseLoadDemand(extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint, fileName = "/home/wspark/projects/LoadProfile/colocation_10MW_2840nodes_60u_power.txt", startTime = 5000, tableName = "LoadData", tableOnFile = true, timeEvents = Modelica.Blocks.Types.TimeEvents.NoTimeEvents) annotation(
    Placement(transformation(origin = {134, 24}, extent = {{10, -10}, {-10, 10}})));
  ThermoPower.Water.Flow1DFV2ph economizer_secondary(A = 0.0001337, Dhyd = 13.05e-3, DynamicMomentum = true, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Colebrook, FluidPhaseStart = ThermoPower.Choices.FluidPhase.FluidPhases.Liquid, redeclare model HeatTransfer = ThermoPower.Thermal.HeatTransferFV.DittusBoelter, Kfc = 2, L = 12.9, N = 10, Nt = 359, dpnom(displayUnit = "kPa") = 176000, e = 0.00015, hstartin = 856795, hstartout = 1559329, noInitialPressure = false, omega = 0.041, pstart(displayUnit = "MPa") = 1.45e7, wnf = 0.5, wnm = 0.1, wnom = 69.08) annotation(
    Placement(transformation(origin = {-224, -38}, extent = {{10, 10}, {-10, -10}}, rotation = -90)));
  ThermoPower.Water.Flow1DFV2ph evaporator_secondary(A = 0.0001337, Dhyd = 13.05e-3, DynamicMomentum = true, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Colebrook, FluidPhaseStart = ThermoPower.Choices.FluidPhase.FluidPhases.TwoPhases, redeclare model HeatTransfer = ThermoPower.Thermal.HeatTransferFV.DittusBoelter, Kfc = 2, L = 10.2, N = 10, Nt = 359, dpnom(displayUnit = "kPa") = 143000, e = 0.00015, hstartin = 1575931, hstartout = 2611643, noInitialPressure = false, omega = 0.041, pstart(displayUnit = "MPa") = 1.44e7, wnf = 0.5, wnm = 0.1, wnom = 69.08) annotation(
    Placement(transformation(origin = {-224, -8}, extent = {{10, 10}, {-10, -10}}, rotation = -90)));
  ThermoPower.Water.Flow1DFV2ph superheater_secondary(A = 0.0001337, Dhyd = 13.05e-3, DynamicMomentum = true, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Colebrook, FluidPhaseStart = ThermoPower.Choices.FluidPhase.FluidPhases.Steam, redeclare model HeatTransfer = ThermoPower.Thermal.HeatTransferFV.DittusBoelter, Kfc = 2, L = 6.9, N = 10, Nt = 359, dpnom(displayUnit = "kPa") = 9e4, e = 0.00015, hstartin = 2660669, hstartout = 3430465, noInitialPressure = false, omega = 0.041, pstart(displayUnit = "MPa") = 1.43e7, wnf = 0.5, wnm = 0.1, wnom = 69.08) annotation(
    Placement(transformation(origin = {-224, 22}, extent = {{10, 10}, {-10, -10}}, rotation = -90)));
  ThermoPower.Gas.Flow1DFV economizer_primary(A = 3.06, Dhyd = 19.05e-3, DynamicMomentum = true, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Kfnom, redeclare model HeatTransfer = ThermoPower.customModel.Models.ZukauskasInLineHTC(pt_OD = 1.5), Kfnom = 27, L = 12.9, redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He, N = 10, Nt = 1, Tstartbar = 650.15, dpnom = 1e5, e = 0.00015, omega = 21.457, pstart(displayUnit = "MPa") = 6e6, wnf = 0.1, wnm = 0.1, wnom = 81.6) annotation(
    Placement(transformation(origin = {-322, -38}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  ThermoPower.Gas.Flow1DFV evaporator_primary(A = 3.06, Dhyd = 19.05e-3, DynamicMomentum = true, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Kfnom, redeclare model HeatTransfer = ThermoPower.customModel.Models.ZukauskasInLineHTC(pt_OD = 1.5), Kfnom = 27, L = 10.2, redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He, N = 10, Nt = 1, Tstartbar = 770.15, dpnom = 1e5, e = 0.00015, omega = 21.457, pstart(displayUnit = "MPa") = 6e6, wnf = 0.1, wnm = 0.1, wnom = 81.6) annotation(
    Placement(transformation(origin = {-322, -8}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  ThermoPower.Gas.Flow1DFV superheater_primary(A = 3.06, Dhyd = 19.05e-3, DynamicMomentum = true, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Kfnom, redeclare model HeatTransfer = ThermoPower.customModel.Models.ZukauskasInLineHTC(pt_OD = 1.5), Kfnom = 27, L = 6.9, redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He, N = 10, Nt = 1, Tstartbar = 1023.15, dpnom = 1e5, e = 0.00015, omega = 21.457, pstart(displayUnit = "MPa") = 6e6, wnf = 0.1, wnm = 0.1, wnom = 81.6) annotation(
    Placement(transformation(origin = {-322, 22}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  ThermoPower.Thermal.MetalTubeFV econonmizer_wall(L = 12.9, Nt = 359, Nw = 9, Tstartbar = 623.15, lambda = 22, rext = 19.05e-3/2, rhomcm = 4000000, rint = 13.05e-3/2) annotation(
    Placement(transformation(origin = {-250, -38}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  ThermoPower.Thermal.CounterCurrentFV counterCurrentFV(Nw = 9) annotation(
    Placement(transformation(origin = {-280, -38}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  ThermoPower.Thermal.MetalTubeFV evaporator_wall(L = 10.2, Nt = 359, Nw = 9, Tstartbar = 723.15, lambda = 22, rext = 19.05e-3/2, rhomcm = 4000000, rint = 13.05e-3/2) annotation(
    Placement(transformation(origin = {-250, -8}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  ThermoPower.Thermal.CounterCurrentFV counterCurrentFV1(Nw = 9) annotation(
    Placement(transformation(origin = {-280, -8}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  ThermoPower.Thermal.MetalTubeFV superheater_wall(L = 6.9, Nt = 359, Nw = 9, Tstartbar = 873.15, lambda = 22, rext = 19.05e-3/2, rhomcm = 4000000, rint = 13.05e-3/2) annotation(
    Placement(transformation(origin = {-250, 22}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  ThermoPower.Thermal.CounterCurrentFV counterCurrentFV2(Nw = 9) annotation(
    Placement(transformation(origin = {-280, 22}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  inner ThermoPower.System system(allowFlowReversal = false, fnom = 60, initOpt = ThermoPower.Choices.Init.Options.fixedState) annotation(
    Placement(transformation(origin = {-178, 166}, extent = {{-10, -10}, {10, 10}})));
  ThermoPower.Electrical.Generator generator(Np = 1, Pnom(displayUnit = "MW") = 6.55e7, fstart = 60, referenceGenerator = true) annotation(
    Placement(transformation(origin = {-62, 36}, extent = {{-10, -10}, {10, 10}})));
  ThermoPower.Water.FlowSplit flowSplit annotation(
    Placement(transformation(origin = {-139, 23}, extent = {{-5, 5}, {5, -5}}, rotation = -90)));
  ThermoPower.Water.Pump CdPump(dp0(displayUnit = "MPa") = 1.41e6, redeclare function efficiencyCharacteristic = ThermoPower.Functions.PumpCharacteristics.constantEfficiency(eta_nom = 0.85), redeclare function flowCharacteristic = ThermoPower.Functions.PumpCharacteristics.quadraticFlow(head_nom = {300.72743947238007, 146.23388533741434, 105.87333298428797}, q_nom = {0, 0.054870609296703905, 0.07133179208571508}), hstart = 193516, n0 = 1800, rho0(displayUnit = "kg/m3") = 983.13, use_in_n = true, w0 = 54.008) annotation(
    Placement(transformation(origin = {-88, -34}, extent = {{10, -10}, {-10, 10}})));
  ThermoPower.Water.Pump FwPump(dp0(displayUnit = "MPa") = 1.3312e7, redeclare function efficiencyCharacteristic = ThermoPower.Functions.PumpCharacteristics.constantEfficiency(eta_nom = 0.85), redeclare function flowCharacteristic = ThermoPower.Functions.PumpCharacteristics.quadraticFlow(head_nom = {3085.5366742612923, 1561.0976244723518, 1130.2346801179826}, q_nom = {0, 0.07947880436649801, 0.10332244567644742}), hstart = 856795, n0 = 1800, rho0(displayUnit = "kg/m3") = 869.24, use_in_n = true, w0 = 69.08) annotation(
    Placement(transformation(origin = {-184, -76}, extent = {{10, -10}, {-10, 10}})));
  ThermoPower.Gas.Flow1DFV hotDuct(A = 0.78, Dhyd = 1, DynamicMomentum = true, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Kfnom, Kfnom = 2, L = 5, redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He, N = 5, Nt = 1, Tstartbar = 1023.15, dpnom(displayUnit = "Pa") = 3000, e = 0.00015, omega = 1*3.14, pstart(displayUnit = "MPa") = 6e6, wnf = 0.5, wnm = 0.1, wnom = 81.6) annotation(
    Placement(transformation(origin = {-382, -26}, extent = {{-10, -10}, {10, 10}})));
  ThermoPower.Gas.Flow1DFV Channel_Avg(A = 2e-4, Dhyd = 1.6e-2, DynamicMomentum = true, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Colebrook, redeclare model HeatTransfer = ThermoPower.Thermal.HeatTransferFV.DittusBoelter(Re_min = 700), L = 8, redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He, N = 21, Nt = 3274, Tstartbar = 823.15, Tstartin = 598.15, Tstartout = 1023.15, dpnom = 1e5, e = 0.00015, noInitialPressure = true, omega = 1.6e-2*3.14, pstart(displayUnit = "MPa") = 6e6, wnf = 0.5, wnm = 0.1, wnom = 81.6*3274/3275) annotation(
    Placement(transformation(origin = {-422, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  ThermoPower.customModel.Models.RadialConduction1D Fuel_mixture_Avg(L = 8, Nr = 5, Nt = 3274, Nw = 20, Tstartbar = 1023.15, axialProfile = {0.04278298, 0.05092866, 0.05695018, 0.06107518, 0.06352006, 0.06449002, 0.06417902, 0.06276982, 0.06043394, 0.0573317, 0.05361218, 0.04941327, 0.04486162, 0.04007265, 0.03515058, 0.03018841, 0.02526791, 0.02045963, 0.01582291, 0.01140586}, lambda = 23.24, rext = 38e-3/2, rhomcm = 2341.42*1800, rint = 25.3e-3/2, useExternalHeatGen = true, useHeatGen = true) annotation(
    Placement(transformation(origin = {-388, 0}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
  ThermoPower.Gas.Flow1DFV coldDuct(A = 0.78, Dhyd = 0.41, DynamicMomentum = true, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Kfnom, Kfnom = 2, L = 5, redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He, N = 5, Nt = 1, Tstartbar = 598.15, dpnom(displayUnit = "Pa") = 3000, e = 0.00015, noInitialPressure = true, omega = 0.41*3.14, pstart(displayUnit = "MPa") = 6e6, wnf = 0.5, wnm = 0.1, wnom = 81.6) annotation(
    Placement(transformation(origin = {-382, -46}, extent = {{10, -10}, {-10, 10}})));
  ThermoPower.customModel.Models.Fan Blower(redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He, dp0(displayUnit = "Pa") = 1.8e5, redeclare function efficiencyCharacteristic = ThermoPower.Functions.PumpCharacteristics.constantEfficiency(eta_nom = 0.85), redeclare function flowCharacteristic = ThermoPower.Functions.FanCharacteristics.quadraticFlow(H_nom = {64854.44254405128, 37753.17324575091, 27333.29742992366}, q_nom = {0, 17.11477187140708, 22.249203432829205}), n0 = 1800, rho0(displayUnit = "kg/m3") = 4.77, use_in_n = true, w0 = 81.6) annotation(
    Placement(transformation(origin = {-356, -54}, extent = {{10, -10}, {-10, 10}})));
  ThermoPower.customModel.Models.RadialConduction1D Graphite_Avg(L = 8, Nr = 5, Nt = 3274, Nw = 20, Tstartbar = 1023.15, lambda = 23.6, rext = 25.3e-3/2, rhomcm = 1780*1979.2, rint = 16e-3/2, useExternalHeatGen = false, useHeatGen = false) annotation(
    Placement(transformation(origin = {-406, 0}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
  ThermoPower.Gas.Header lowerPlenum(redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He, Tmstart = 598.15, Tstart = 598.15, V = 62.59, pstart(displayUnit = "MPa") = 6e6) annotation(
    Placement(transformation(origin = {-512, -38}, extent = {{10, -10}, {-10, 10}})));
  ThermoPower.Gas.Header upperPlenum(redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He, Tmstart = 598.15, Tstart = 598.15, V = 53.88, pstart(displayUnit = "MPa") = 6e6) annotation(
    Placement(transformation(origin = {-476, 60}, extent = {{-10, -10}, {10, 10}})));
  ThermoPower.Electrical.PowerSensor sens_power annotation(
    Placement(transformation(origin = {-30, 36}, extent = {{-10, 10}, {10, -10}})));
  ThermoPower.Gas.Flow1DFV Channel_Hot(A = 2e-4, Dhyd = 1.6e-2, DynamicMomentum = true, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Colebrook, redeclare model HeatTransfer = ThermoPower.Thermal.HeatTransferFV.DittusBoelter(Re_min = 700), L = 8, redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He, N = 21, Nt = 1, Tstartbar = 823.15, Tstartin = 598.15, Tstartout = 1023.15, dpnom = 1e5, e = 0.00015, omega = 1.6e-2*3.14, pstart(displayUnit = "MPa") = 6e6, wnf = 0.5, wnm = 0.1, wnom = 81.6*1/3275) annotation(
    Placement(transformation(origin = {-448, 0}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
  ThermoPower.customModel.Models.RadialConduction1D Fuel_mixture_Hot(L = 8, Nr = 5, Nt = 1, Nw = 20, Tstartbar = 1023.15, axialProfile = {0.04278298, 0.05092866, 0.05695018, 0.06107518, 0.06352006, 0.06449002, 0.06417902, 0.06276982, 0.06043394, 0.0573317, 0.05361218, 0.04941327, 0.04486162, 0.04007265, 0.03515058, 0.03018841, 0.02526791, 0.02045963, 0.01582291, 0.01140586}, lambda = 23.24, rext = 38e-3/2, rhomcm = 2341.42*1800, rint = 25.3e-3/2, useExternalHeatGen = true, useHeatGen = true) annotation(
    Placement(transformation(origin = {-480, 0}, extent = {{10, 10}, {-10, -10}}, rotation = 90)));
  ThermoPower.customModel.Models.RadialConduction1D Graphite_Hot(L = 8, Nr = 5, Nt = 1, Nw = 20, Tstartbar = 1023.15, lambda = 23.6, rext = 25.3e-3/2, rhomcm = 1780*1979.2, rint = 16e-3/2, useExternalHeatGen = false, useHeatGen = false) annotation(
    Placement(transformation(origin = {-464, 0}, extent = {{10, 10}, {-10, -10}}, rotation = 90)));
  ThermoPower.Water.ValveVap valve_turbine(CvData = ThermoPower.Choices.Valve.CvTypes.OpPoint, redeclare function FlowChar = ThermoPower.Functions.ValveCharacteristics.quadratic, dpnom(displayUnit = "Pa") = 5e5, pnom(displayUnit = "Pa") = 1.43e7, rhonom(displayUnit = "kg/m3") = 41.35, theta_fix = 0.85, thetanom = 0.85, useThetaInput = true, wnom = 69.08) annotation(
    Placement(transformation(origin = {-207, 43}, extent = {{-5, -5}, {5, 5}})));
  ThermoPower.Water.ValveVap valve_extraction(CvData = ThermoPower.Choices.Valve.CvTypes.OpPoint, redeclare function FlowChar = ThermoPower.Functions.ValveCharacteristics.quadratic, dpnom(displayUnit = "Pa") = 143000, pnom(displayUnit = "Pa") = 1.573e6, rhonom(displayUnit = "kg/m3") = 6.719, theta_fix = 0.5, thetanom = 0.5, useThetaInput = false, wnom = 15.079) annotation(
    Placement(transformation(origin = {-141, -9}, extent = {{-5, 5}, {5, -5}}, rotation = -90)));
  ThermoPower.customModel.Models.ReactorPower reactorPower_Avg(P0 = 180e6/(3274 + 1.59)*3274, Tf0 = 943, Tm0 = 926, alpha_f = -4.2e-5, alpha_m = -8.55e-5, usePKE = true, useRhoExt = true, useTc = false, useTf = true, useTm = true, useXe = true) annotation(
    Placement(transformation(origin = {-390, 58}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Constant signal_constant(k = 1) annotation(
    Placement(transformation(origin = {-288, 172}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  ThermoPower.Gas.SensT1 sens_T_He(redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He) annotation(
    Placement(transformation(origin = {-322, 86}, extent = {{10, -10}, {-10, 10}})));
  ThermoPower.customModel.Blocks.LimPID_Tinit PID_reactivity(Ti = 50, controllerType = Modelica.Blocks.Types.SimpleController.PI, initType = Modelica.Blocks.Types.InitPID.InitialState, k = 0.5, u_m_nom = 1023, useInitTime = false, xi_start = 0/0.003, yMax = 50e-3, yMin = -50e-3, y_start = 0) annotation(
    Placement(transformation(origin = {-356, 92}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
  Modelica.Blocks.Math.Gain Gain_HotChannel(k = 1.59/3274) annotation(
    Placement(transformation(origin = {-438, 90}, extent = {{10, 10}, {-10, -10}})));
  ThermoPower.Water.SensP sens_P_steam annotation(
    Placement(transformation(origin = {-224, 68}, extent = {{10, -10}, {-10, 10}})));
  ThermoPower.customModel.Blocks.LimPID_Tinit PID_blower(Ti = 35, controllerType = Modelica.Blocks.Types.SimpleController.PI, initType = Modelica.Blocks.Types.InitPID.InitialState, k = 1.5, u_m_nom = 14.3e6, useInitTime = false, xi_start = 1/1.5, yMax = 1.2, yMin = 0.1, y_start = 1) annotation(
    Placement(transformation(origin = {-250, 98}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Blocks.Math.Gain Gain_blower(k = 1800) annotation(
    Placement(transformation(origin = {-288, 98}, extent = {{10, 10}, {-10, -10}})));
  ThermoPower.Water.SensT1 sens_T_steam annotation(
    Placement(transformation(origin = {-198, 68}, extent = {{-10, -10}, {10, 10}})));
  ThermoPower.customModel.Blocks.LimPID_Tinit PID_fwpp(Ti = 35, controllerType = Modelica.Blocks.Types.SimpleController.PI, initType = Modelica.Blocks.Types.InitPID.InitialState, k = 1.5, u_s_nom = 823, useInitTime = false, xi_start = 1/1.5, yMax = 1.2, yMin = 0.1, y_start = 1) annotation(
    Placement(transformation(origin = {-166, 74}, extent = {{-10, 10}, {10, -10}})));
  Modelica.Blocks.Math.Gain Gain_fwpp(k = 1800) annotation(
    Placement(transformation(origin = {-130, 74}, extent = {{10, -10}, {-10, 10}}, rotation = -180)));
  ThermoPower.customModel.Models.Deaerator Deaerator(V = 25, pstart(displayUnit = "MPa") = 1.43e6) annotation(
    Placement(transformation(origin = {-132, -44}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
  ThermoPower.customModel.Blocks.LimPID_Tinit PID_cdpp(Ti = 50, controllerType = Modelica.Blocks.Types.SimpleController.PI, initType = Modelica.Blocks.Types.InitPID.InitialState, k = 3.4, u_m_nom = 0.85, useInitTime = false, xi_start = 1/3.4, yMax = 1.2, yMin = 0.1, y_start = 1) annotation(
    Placement(transformation(origin = {-52, -62}, extent = {{10, 10}, {-10, -10}})));
  Modelica.Blocks.Math.Gain Gain_cdpp(k = 1800) annotation(
    Placement(transformation(origin = {-86, -62}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  ThermoPower.customModel.Models.SteamTurbineStodolaEta HPTB(Kt = 0.00296, PRstart = 8.773, eta_iso_nom = 0.85, pnom(displayUnit = "MPa") = 1.38e7, useMflowCorrection = true, useWetnessCorrection = true, wnom = 69.08) annotation(
    Placement(transformation(origin = {-168, 36}, extent = {{-10, -10}, {10, 10}})));
  ThermoPower.customModel.Models.SteamTurbineStodolaEta LPTB(Kt = 0.01661, PRstart = 78.65, eta_iso_nom = 0.85, pnom(displayUnit = "MPa") = 1.573e6, useMflowCorrection = true, useWetnessCorrection = true, wnom = 54.008) annotation(
    Placement(transformation(origin = {-116, 36}, extent = {{-10, -10}, {10, 10}})));
  ThermoPower.customModel.Models.Grid_v grid_v(Pgrid(displayUnit = "W") = 65.5e6, pset_const = 65.5e6, use_in_pset = true) annotation(
    Placement(transformation(origin = {14, 36}, extent = {{-10, -10}, {10, 10}})));
  ThermoPower.customModel.Blocks.LimPID_Tinit PID_valve(Ti = 30, controllerType = Modelica.Blocks.Types.SimpleController.PI, initType = Modelica.Blocks.Types.InitPID.InitialState, k = 75, u_m_nom = 60, useInitTime = false, xi_start = 0.85/75, yMax = 1, yMin = 0.05, y_start = 1) annotation(
    Placement(transformation(origin = {6, 106}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Blocks.Math.Gain gain(k = 65.5e6) annotation(
    Placement(transformation(origin = {48, 52}, extent = {{10, -10}, {-10, 10}})));
  ThermoPower.Electrical.FrequencySensor sens_frequency annotation(
    Placement(transformation(origin = {6, 66}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  ThermoPower.Gas.Flow1DFV riser(A = 3.74, Dhyd = 0.54, DynamicMomentum = true, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Kfnom, Kfnom = 2, L = 8, redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He, N = 5, Nt = 1, Tstartbar = 598.15, dpnom(displayUnit = "Pa") = 3000, e = 0.00015, noInitialPressure = true, omega = 0.54*3.14, pstart(displayUnit = "MPa") = 6e6, wnf = 0.5, wnm = 0.1, wnom = 81.6) annotation(
    Placement(transformation(origin = {-536, 2}, extent = {{10, 10}, {-10, -10}}, rotation = -90)));
  Modelica.Blocks.Continuous.Derivative RhoDerivative(T = 0.1, initType = Modelica.Blocks.Types.Init.InitialState) annotation(
    Placement(transformation(origin = {-408, 130}, extent = {{10, -10}, {-10, 10}})));
  ThermoPower.customModel.Models.RadialConduction1D Graphite_Hot_Adjacent(L = 8, Nr = 5, Nt = 6, Nw = 20, Tstartbar = 1023.15, lambda = 23.6, rext = 38e-3/2*2, rhomcm = 1780*1979.2, rint = 38e-3/2, useExternalHeatGen = false, useHeatGen = false) annotation(
    Placement(transformation(origin = {-498, 0}, extent = {{10, 10}, {-10, -10}}, rotation = 90)));
  ThermoPower.Thermal.ConvHTFV conv_adjacent(G = 430*(2*3.14*16e-3/2*8)*6, Nv = 20) annotation(
    Placement(transformation(origin = {-468, -58}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  ThermoPower.Thermal.TempSource1DFV tempSource1DFV(Nw = 20) annotation(
    Placement(transformation(origin = {-448, -58}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Sources.Constant AvgTemp_constant(k = 1023) annotation(
    Placement(transformation(origin = {-420, -58}, extent = {{10, -10}, {-10, 10}})));
  ThermoPower.customModel.Models.Condenser_ACC Condenser(cm = 500, condExchSurface = 4802.84, condNomFlowRate = 54.008, condNomPressure(displayUnit = "kPa") = 2e4, condVol = 26.415, coolExchSurface = 105837, coolNomFlowRate = 7433.86, coolNomPressure = 1e5, coolVol = 4157, gamma_cond = 15e3, gamma_cool = 42, metalVol = 141, pstart_cond(displayUnit = "kPa") = 2e4, rhoMetal(displayUnit = "kg/m3") = 8000) annotation(
    Placement(transformation(origin = {-14, -14}, extent = {{-10, -10}, {10, 10}})));
  ThermoPower.Gas.SourceMassFlow sourceMassFlow1(redeclare package Medium = Modelica.Media.Air.SimpleAir, T = 298.15, p0 = 1e5, w0 = 7433.86) annotation(
    Placement(transformation(origin = {22, -32}, extent = {{10, -10}, {-10, 10}})));
  ThermoPower.Gas.SinkPressure sinkPressure1(redeclare package Medium = Modelica.Media.Air.SimpleAir, T = 313.15, p0 = 1e5) annotation(
    Placement(transformation(origin = {22, 2}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(ramp31.y, LoadDemand.u1) annotation(
    Line(points = {{123, 88}, {110, 88}, {110, 60}, {98, 60}}, color = {0, 0, 127}));
  connect(booleanExpression1.y, LoadDemand.u2) annotation(
    Line(points = {{123, 52}, {98, 52}}, color = {255, 0, 255}));
  connect(BaseLoadDemand.y[1], LoadDemand.u3) annotation(
    Line(points = {{123, 24}, {109, 24}, {109, 44}, {97, 44}}, color = {0, 0, 127}));
  connect(economizer_secondary.outfl, evaporator_secondary.infl) annotation(
    Line(points = {{-224, -28}, {-224, -18}}, color = {0, 0, 255}));
  connect(evaporator_secondary.outfl, superheater_secondary.infl) annotation(
    Line(points = {{-224, 2}, {-224, 12}}, color = {0, 0, 255}));
  connect(counterCurrentFV.side1, econonmizer_wall.ext) annotation(
    Line(points = {{-277, -38}, {-253, -38}}, color = {255, 127, 0}));
  connect(economizer_primary.wall, counterCurrentFV.side2) annotation(
    Line(points = {{-317, -38}, {-283, -38}}, color = {255, 127, 0}));
  connect(econonmizer_wall.int, economizer_secondary.wall) annotation(
    Line(points = {{-247, -38}, {-228, -38}}, color = {255, 127, 0}));
  connect(counterCurrentFV1.side1, evaporator_wall.ext) annotation(
    Line(points = {{-277, -8}, {-253, -8}}, color = {255, 127, 0}));
  connect(counterCurrentFV2.side1, superheater_wall.ext) annotation(
    Line(points = {{-277, 22}, {-253, 22}}, color = {255, 127, 0}));
  connect(evaporator_primary.wall, counterCurrentFV1.side2) annotation(
    Line(points = {{-317, -8}, {-283, -8}}, color = {255, 127, 0}));
  connect(evaporator_wall.int, evaporator_secondary.wall) annotation(
    Line(points = {{-247, -8}, {-229, -8}}, color = {255, 127, 0}));
  connect(superheater_primary.wall, counterCurrentFV2.side2) annotation(
    Line(points = {{-317, 22}, {-283, 22}}, color = {255, 127, 0}));
  connect(superheater_wall.int, superheater_secondary.wall) annotation(
    Line(points = {{-247, 22}, {-229, 22}}, color = {255, 127, 0}));
  connect(superheater_primary.outfl, evaporator_primary.infl) annotation(
    Line(points = {{-322, 12}, {-322, 2}}, color = {159, 159, 223}));
  connect(evaporator_primary.outfl, economizer_primary.infl) annotation(
    Line(points = {{-322, -18}, {-322, -28}}, color = {159, 159, 223}));
  connect(Graphite_Avg.int, Channel_Avg.wall) annotation(
    Line(points = {{-409, 0}, {-417, 0}}, color = {255, 127, 0}));
  connect(Fuel_mixture_Avg.int, Graphite_Avg.ext) annotation(
    Line(points = {{-391, 0}, {-403, 0}}, color = {255, 127, 0}));
  connect(Blower.infl, economizer_primary.outfl) annotation(
    Line(points = {{-348, -51.8}, {-348, -47.8}, {-322, -47.8}}, color = {159, 159, 223}));
  connect(coldDuct.infl, Blower.outfl) annotation(
    Line(points = {{-372, -46}, {-372, -47}, {-362, -47}}, color = {159, 159, 223}));
  connect(hotDuct.outfl, superheater_primary.infl) annotation(
    Line(points = {{-372, -26}, {-350, -26}, {-350, 48}, {-322, 48}, {-322, 32}}, color = {159, 159, 223}));
  connect(coldDuct.outfl, lowerPlenum.inlet) annotation(
    Line(points = {{-392, -46}, {-412, -46}, {-412, -38}, {-502, -38}}, color = {159, 159, 223}));
  connect(economizer_secondary.infl, FwPump.outfl) annotation(
    Line(points = {{-224, -48}, {-222, -48}, {-222, -69}, {-190, -69}}, color = {0, 0, 255}));
  connect(generator.port, sens_power.port_a) annotation(
    Line(points = {{-53.4, 36}, {-40.4, 36}}, color = {0, 0, 255}));
  connect(Fuel_mixture_Hot.int, Graphite_Hot.ext) annotation(
    Line(points = {{-477, 0}, {-468, 0}}, color = {255, 127, 0}));
  connect(Graphite_Hot.int, Channel_Hot.wall) annotation(
    Line(points = {{-461, 0}, {-452, 0}}, color = {255, 127, 0}));
  connect(upperPlenum.outlet, Channel_Hot.infl) annotation(
    Line(points = {{-466, 60}, {-448, 60}, {-448, 10}}, color = {159, 159, 223}));
  connect(upperPlenum.outlet, Channel_Avg.infl) annotation(
    Line(points = {{-466, 60}, {-422, 60}, {-422, 10}}, color = {159, 159, 223}));
  connect(Channel_Avg.outfl, hotDuct.infl) annotation(
    Line(points = {{-422, -10}, {-422, -26}, {-392, -26}}, color = {159, 159, 223}));
  connect(Channel_Hot.outfl, hotDuct.infl) annotation(
    Line(points = {{-448, -10}, {-448, -26}, {-392, -26}}, color = {159, 159, 223}));
  connect(superheater_secondary.outfl, valve_turbine.inlet) annotation(
    Line(points = {{-224, 32}, {-224, 43}, {-212, 43}}, color = {0, 0, 255}));
  connect(flowSplit.out1, valve_extraction.inlet) annotation(
    Line(points = {{-141, 20}, {-141, -4}}, color = {0, 0, 255}));
  connect(superheater_primary.infl, sens_T_He.flange) annotation(
    Line(points = {{-322, 32}, {-322, 82}}, color = {159, 159, 223}));
  connect(sens_T_He.T, PID_reactivity.u_m) annotation(
    Line(points = {{-329, 92}, {-345, 92}}, color = {0, 0, 127}));
  connect(signal_constant.y, PID_reactivity.u_s) annotation(
    Line(points = {{-288, 161}, {-288, 133}, {-356, 133}, {-356, 103}}, color = {0, 0, 127}));
  connect(PID_reactivity.y, reactorPower_Avg.rho_ext) annotation(
    Line(points = {{-356, 81}, {-356, 72}, {-414, 72}, {-414, 58}, {-398, 58}}, color = {0, 0, 127}));
  connect(Fuel_mixture_Avg.Tm_avg, reactorPower_Avg.Tf) annotation(
    Line(points = {{-390, 10.2}, {-396, 10.2}, {-396, 50.2}}, color = {0, 0, 127}));
  connect(Graphite_Avg.Tm_avg, reactorPower_Avg.Tm) annotation(
    Line(points = {{-408, 10.2}, {-408, 28.2}, {-390, 28.2}, {-390, 50.2}}, color = {0, 0, 127}));
  connect(reactorPower_Avg.Power, Fuel_mixture_Avg.heatGenInput) annotation(
    Line(points = {{-381, 58}, {-371, 58}, {-371, 22}, {-387, 22}, {-387, 10}}, color = {0, 0, 127}));
  connect(reactorPower_Avg.Power, Gain_HotChannel.u) annotation(
    Line(points = {{-381, 58}, {-379, 58}, {-379, 90}, {-427, 90}}, color = {0, 0, 127}));
  connect(Gain_HotChannel.y, Fuel_mixture_Hot.heatGenInput) annotation(
    Line(points = {{-449, 90}, {-511, 90}, {-511, 24}, {-483, 24}, {-483, 10}}, color = {0, 0, 127}));
  connect(superheater_secondary.outfl, sens_P_steam.flange) annotation(
    Line(points = {{-224, 32}, {-224, 64}}, color = {0, 0, 255}));
  connect(sens_P_steam.p, PID_blower.u_m) annotation(
    Line(points = {{-232, 74}, {-250, 74}, {-250, 86}}, color = {0, 0, 127}));
  connect(signal_constant.y, PID_blower.u_s) annotation(
    Line(points = {{-288, 161}, {-288, 133}, {-226, 133}, {-226, 97}, {-238, 97}}, color = {0, 0, 127}));
  connect(PID_blower.y, Gain_blower.u) annotation(
    Line(points = {{-261, 98}, {-277, 98}}, color = {0, 0, 127}));
  connect(Gain_blower.y, Blower.in_n) annotation(
    Line(points = {{-299, 98}, {-305, 98}, {-305, 56}, {-357, 56}, {-357, -46}}, color = {0, 0, 127}));
  connect(superheater_secondary.outfl, sens_T_steam.flange) annotation(
    Line(points = {{-224, 32}, {-224, 52}, {-198, 52}, {-198, 64}}, color = {0, 0, 255}));
  connect(sens_T_steam.T, PID_fwpp.u_s) annotation(
    Line(points = {{-190, 74}, {-178, 74}}, color = {0, 0, 127}));
  connect(signal_constant.y, PID_fwpp.u_m) annotation(
    Line(points = {{-288, 161}, {-288, 133}, {-166, 133}, {-166, 85}}, color = {0, 0, 127}));
  connect(PID_fwpp.y, Gain_fwpp.u) annotation(
    Line(points = {{-155, 74}, {-143, 74}}, color = {0, 0, 127}));
  connect(Gain_fwpp.y, FwPump.in_n) annotation(
    Line(points = {{-119, 74}, {-95, 74}, {-95, 8}, {-183, 8}, {-183, -68}}, color = {0, 0, 127}));
  connect(valve_extraction.outlet, Deaerator.SteamIn) annotation(
    Line(points = {{-141, -14}, {-138, -14}, {-138, -36}}, color = {0, 0, 255}));
  connect(CdPump.outfl, Deaerator.WaterIn) annotation(
    Line(points = {{-94, -27}, {-96, -27}, {-96, -17}, {-126, -17}, {-126, -37}}, color = {0, 0, 255}));
  connect(Deaerator.CondOut, FwPump.infl) annotation(
    Line(points = {{-132, -54}, {-132, -74}, {-176, -74}}, color = {0, 0, 255}));
  connect(signal_constant.y, PID_cdpp.u_s) annotation(
    Line(points = {{-288, 161}, {-288, 133}, {70, 133}, {70, -63}, {-40, -63}}, color = {0, 0, 127}));
  connect(PID_cdpp.y, Gain_cdpp.u) annotation(
    Line(points = {{-63, -62}, {-75, -62}}, color = {0, 0, 127}));
  connect(Gain_cdpp.y, CdPump.in_n) annotation(
    Line(points = {{-97, -62}, {-111, -62}, {-111, -12}, {-87, -12}, {-87, -26}}, color = {0, 0, 127}));
  connect(valve_turbine.outlet, HPTB.inlet) annotation(
    Line(points = {{-202, 43}, {-189, 43}, {-189, 44}, {-176, 44}}, color = {0, 0, 255}));
  connect(HPTB.outlet, flowSplit.in1) annotation(
    Line(points = {{-160, 44}, {-160, 26}, {-138, 26}}, color = {0, 0, 255}));
  connect(flowSplit.out2, LPTB.inlet) annotation(
    Line(points = {{-137, 20}, {-131, 20}, {-131, 44}, {-125, 44}}, color = {0, 0, 255}));
  connect(HPTB.shaft_b, LPTB.shaft_a) annotation(
    Line(points = {{-161.6, 36}, {-122.6, 36}}));
  connect(LPTB.shaft_b, generator.shaft) annotation(
    Line(points = {{-109.6, 36}, {-69.6, 36}}));
  connect(grid_v.port, sens_power.port_b) annotation(
    Line(points = {{5.4, 36}, {-19.6, 36}}, color = {0, 0, 255}));
  connect(PID_valve.y, valve_turbine.theta) annotation(
    Line(points = {{-5, 106}, {-80, 106}, {-80, 50}, {-206, 50}, {-206, 48}}, color = {0, 0, 127}));
  connect(gain.y, grid_v.pset) annotation(
    Line(points = {{37, 52}, {10, 52}, {10, 44}}, color = {0, 0, 127}));
  connect(grid_v.port, sens_frequency.port) annotation(
    Line(points = {{5.4, 36}, {5.4, 56}}, color = {0, 0, 255}));
  connect(signal_constant.y, PID_valve.u_s) annotation(
    Line(points = {{-288, 161}, {-288, 133}, {38, 133}, {38, 105}, {18, 105}}, color = {0, 0, 127}));
  connect(sens_frequency.f, PID_valve.u_m) annotation(
    Line(points = {{6, 76.2}, {6, 94.2}}, color = {0, 0, 127}));
  connect(lowerPlenum.outlet, riser.infl) annotation(
    Line(points = {{-522, -38}, {-536, -38}, {-536, -8}}, color = {159, 159, 223}));
  connect(riser.outfl, upperPlenum.inlet) annotation(
    Line(points = {{-536, 12}, {-534, 12}, {-534, 60}, {-486, 60}}, color = {159, 159, 223}));
  connect(PID_reactivity.y, RhoDerivative.u) annotation(
    Line(points = {{-356, 81}, {-356, 71}, {-386, 71}, {-386, 129}, {-396, 129}}, color = {0, 0, 127}));
  connect(Graphite_Hot_Adjacent.int, Fuel_mixture_Hot.ext) annotation(
    Line(points = {{-495, 0}, {-485, 0}}, color = {255, 127, 0}));
  connect(Graphite_Hot_Adjacent.ext, conv_adjacent.side2) annotation(
    Line(points = {{-501.1, 0}, {-513.1, 0}, {-513.1, -26}, {-483.1, -26}, {-483.1, -58}, {-471.1, -58}}, color = {255, 127, 0}));
  connect(tempSource1DFV.wall, conv_adjacent.side1) annotation(
    Line(points = {{-451, -58}, {-465, -58}}, color = {255, 127, 0}));
  connect(AvgTemp_constant.y, tempSource1DFV.temperature) annotation(
    Line(points = {{-431, -58}, {-445, -58}}, color = {0, 0, 127}));
  connect(LoadDemand.y, gain.u) annotation(
    Line(points = {{76, 52}, {60, 52}}, color = {0, 0, 127}));
  connect(LPTB.outlet, Condenser.steamIn) annotation(
    Line(points = {{-108, 44}, {-84, 44}, {-84, 4}, {-15, 4}, {-15, -4}}, color = {0, 0, 255}));
  connect(Condenser.waterOut, CdPump.infl) annotation(
    Line(points = {{-15, -24}, {-16, -24}, {-16, -32}, {-80, -32}}, color = {0, 0, 255}));
  connect(sourceMassFlow1.flange, Condenser.coolingIn) annotation(
    Line(points = {{12, -32}, {4, -32}, {4, -18}, {-4, -18}}, color = {159, 159, 223}));
  connect(Condenser.coolingOut, sinkPressure1.flange) annotation(
    Line(points = {{-4, -8}, {4, -8}, {4, 2}, {12, 2}}, color = {159, 159, 223}));
  connect(Condenser.ratio_VvonVtot, PID_cdpp.u_m) annotation(
    Line(points = {{-24, -12}, {-52, -12}, {-52, -50}}, color = {0, 0, 127}));
  annotation(
    experiment(StartTime = 0, StopTime = 5000, Tolerance = 1e-06, Interval = 100),
    Diagram(coordinateSystem(extent = {{-500, 140}, {100, -60}})),
    Documentation(info = "<HTML>
<p>Annual whole facility load is given as external demand. Initial 1000s for equilibrium, then ramp down to 16% (start power of facility demand). Maintain the state up to 5000s, after which facility demand is given.<p>
</ul>
</html>"),
  __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian",
  __OpenModelica_simulationFlags(lv = "LOG_STDOUT,LOG_ASSERT,LOG_STATS", s = "dassl"));
end BaseLoad_PID;