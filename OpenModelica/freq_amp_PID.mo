within ReferenceOM.Characterization;

  model freq_amp_PID "Reference model for PID-version freq_amp analysis. Compatible with v0.25"
    Modelica.Blocks.Math.Gain gain(k = 65.5e6) annotation(
      Placement(transformation(origin = {240, 18}, extent = {{10, -10}, {-10, 10}})));
    ThermoPower.Water.Flow1DFV2ph economizer_secondary(A = 0.0001337, Dhyd = 13.05e-3, DynamicMomentum = true, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Colebrook, FluidPhaseStart = ThermoPower.Choices.FluidPhase.FluidPhases.Liquid, redeclare model HeatTransfer = ThermoPower.Thermal.HeatTransferFV.DittusBoelter, Kfc = 2, L = 12.9, N = 10, Nt = 359, dpnom(displayUnit = "kPa") = 176000, e = 0.00015, hstartin = 856795, hstartout = 1559329, noInitialPressure = false, omega = 0.041, pstart(displayUnit = "MPa") = 1.45e7, wnf = 0.5, wnm = 0.1, wnom = 69.08) annotation(
      Placement(transformation(origin = {-30, -86}, extent = {{10, 10}, {-10, -10}}, rotation = -90)));
    ThermoPower.Water.Flow1DFV2ph evaporator_secondary(A = 0.0001337, Dhyd = 13.05e-3, DynamicMomentum = true, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Colebrook, FluidPhaseStart = ThermoPower.Choices.FluidPhase.FluidPhases.TwoPhases, redeclare model HeatTransfer = ThermoPower.Thermal.HeatTransferFV.DittusBoelter, Kfc = 2, L = 10.2, N = 10, Nt = 359, dpnom(displayUnit = "kPa") = 143000, e = 0.00015, hstartin = 1575931, hstartout = 2611643, noInitialPressure = false, omega = 0.041, pstart(displayUnit = "MPa") = 1.44e7, wnf = 0.5, wnm = 0.1, wnom = 69.08) annotation(
      Placement(transformation(origin = {-30, -56}, extent = {{10, 10}, {-10, -10}}, rotation = -90)));
    ThermoPower.Water.Flow1DFV2ph superheater_secondary(A = 0.0001337, Dhyd = 13.05e-3, DynamicMomentum = true, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Colebrook, FluidPhaseStart = ThermoPower.Choices.FluidPhase.FluidPhases.Steam, redeclare model HeatTransfer = ThermoPower.Thermal.HeatTransferFV.DittusBoelter, Kfc = 2, L = 6.9, N = 10, Nt = 359, dpnom(displayUnit = "kPa") = 9e4, e = 0.00015, hstartin = 2660669, hstartout = 3430465, noInitialPressure = false, omega = 0.041, pstart(displayUnit = "MPa") = 1.43e7, wnf = 0.5, wnm = 0.1, wnom = 69.08) annotation(
      Placement(transformation(origin = {-30, -26}, extent = {{10, 10}, {-10, -10}}, rotation = -90)));
    ThermoPower.Gas.Flow1DFV economizer_primary(A = 3.06, Dhyd = 19.05e-3, DynamicMomentum = true, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Kfnom, redeclare model HeatTransfer = ThermoPower.customModel.Models.ZukauskasInLineHTC(pt_OD = 1.5), Kfnom = 27, L = 12.9, redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He, N = 10, Nt = 1, Tstartbar = 650.15, dpnom = 1e5, e = 0.00015, omega = 21.457, pstart(displayUnit = "MPa") = 6e6, wnf = 0.1, wnm = 0.1, wnom = 81.6) annotation(
      Placement(transformation(origin = {-128, -86}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    ThermoPower.Gas.Flow1DFV evaporator_primary(A = 3.06, Dhyd = 19.05e-3, DynamicMomentum = true, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Kfnom, redeclare model HeatTransfer = ThermoPower.customModel.Models.ZukauskasInLineHTC(pt_OD = 1.5), Kfnom = 27, L = 10.2, redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He, N = 10, Nt = 1, Tstartbar = 770.15, dpnom = 1e5, e = 0.00015, omega = 21.457, pstart(displayUnit = "MPa") = 6e6, wnf = 0.1, wnm = 0.1, wnom = 81.6) annotation(
      Placement(transformation(origin = {-128, -56}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    ThermoPower.Gas.Flow1DFV superheater_primary(A = 3.06, Dhyd = 19.05e-3, DynamicMomentum = true, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Kfnom, redeclare model HeatTransfer = ThermoPower.customModel.Models.ZukauskasInLineHTC(pt_OD = 1.5), Kfnom = 27, L = 6.9, redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He, N = 10, Nt = 1, Tstartbar = 1023.15, dpnom = 1e5, e = 0.00015, omega = 21.457, pstart(displayUnit = "MPa") = 6e6, wnf = 0.1, wnm = 0.1, wnom = 81.6) annotation(
      Placement(transformation(origin = {-128, -26}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    ThermoPower.Thermal.MetalTubeFV econonmizer_wall(L = 12.9, Nt = 359, Nw = 9, Tstartbar = 623.15, lambda = 22, rext = 19.05e-3/2, rhomcm = 4000000, rint = 13.05e-3/2) annotation(
      Placement(transformation(origin = {-56, -86}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    ThermoPower.Thermal.CounterCurrentFV counterCurrentFV(Nw = 9) annotation(
      Placement(transformation(origin = {-86, -86}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    ThermoPower.Thermal.MetalTubeFV evaporator_wall(L = 10.2, Nt = 359, Nw = 9, Tstartbar = 723.15, lambda = 22, rext = 19.05e-3/2, rhomcm = 4000000, rint = 13.05e-3/2) annotation(
      Placement(transformation(origin = {-56, -56}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    ThermoPower.Thermal.CounterCurrentFV counterCurrentFV1(Nw = 9) annotation(
      Placement(transformation(origin = {-86, -56}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    ThermoPower.Thermal.MetalTubeFV superheater_wall(L = 6.9, Nt = 359, Nw = 9, Tstartbar = 873.15, lambda = 22, rext = 19.05e-3/2, rhomcm = 4000000, rint = 13.05e-3/2) annotation(
      Placement(transformation(origin = {-56, -26}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    ThermoPower.Thermal.CounterCurrentFV counterCurrentFV2(Nw = 9) annotation(
      Placement(transformation(origin = {-86, -26}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    inner ThermoPower.System system(allowFlowReversal = false, fnom = 60, initOpt = ThermoPower.Choices.Init.Options.fixedState) annotation(
      Placement(transformation(origin = {16, 118}, extent = {{-10, -10}, {10, 10}})));
    ThermoPower.Electrical.Generator generator(Np = 1, Pnom = 65.5e6, fstart = 60, referenceGenerator = true) annotation(
      Placement(transformation(origin = {132, -12}, extent = {{-10, -10}, {10, 10}})));
    ThermoPower.Water.FlowSplit flowSplit annotation(
      Placement(transformation(origin = {55, -25}, extent = {{-5, 5}, {5, -5}}, rotation = -90)));
    ThermoPower.Water.Pump CdPump(dp0(displayUnit = "MPa") = 1.41e6, redeclare function efficiencyCharacteristic = ThermoPower.Functions.PumpCharacteristics.constantEfficiency(eta_nom = 0.85), redeclare function flowCharacteristic = ThermoPower.Functions.PumpCharacteristics.quadraticFlow(head_nom = {300.72743947238007, 146.23388533741434, 105.87333298428797}, q_nom = {0, 0.054870609296703905, 0.07133179208571508}), hstart = 193516, n0 = 1800, rho0(displayUnit = "kg/m3") = 983.13, use_in_n = true, w0 = 54.008) annotation(
      Placement(transformation(origin = {106, -82}, extent = {{10, -10}, {-10, 10}})));
    ThermoPower.Water.Pump FwPump(dp0(displayUnit = "MPa") = 1.3312e7, redeclare function efficiencyCharacteristic = ThermoPower.Functions.PumpCharacteristics.constantEfficiency(eta_nom = 0.85), redeclare function flowCharacteristic = ThermoPower.Functions.PumpCharacteristics.quadraticFlow(head_nom = {3085.5366742612923, 1561.0976244723518, 1130.2346801179826}, q_nom = {0, 0.07947880436649801, 0.10332244567644742}), hstart = 856795, n0 = 1800, rho0(displayUnit = "kg/m3") = 869.24, use_in_n = true, w0 = 69.08) annotation(
      Placement(transformation(origin = {10, -124}, extent = {{10, -10}, {-10, 10}})));
    ThermoPower.Gas.Flow1DFV hotDuct(A = 0.78, Dhyd = 1, DynamicMomentum = true, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Kfnom, Kfnom = 2, L = 5, redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He, N = 5, Nt = 1, Tstartbar = 1023.15, dpnom(displayUnit = "Pa") = 3000, e = 0.00015, omega = 1*3.14, pstart(displayUnit = "MPa") = 6e6, wnf = 0.5, wnm = 0.1, wnom = 81.6) annotation(
      Placement(transformation(origin = {-188, -74}, extent = {{-10, -10}, {10, 10}})));
    ThermoPower.Gas.Flow1DFV Channel_Avg(A = 2e-4, Dhyd = 1.6e-2, DynamicMomentum = true, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Colebrook, redeclare model HeatTransfer = ThermoPower.Thermal.HeatTransferFV.DittusBoelter(Re_min = 700), L = 8, redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He, N = 21, Nt = 3274, Tstartbar = 823.15, Tstartin = 598.15, Tstartout = 1023.15, dpnom = 1e5, e = 0.00015, noInitialPressure = true, omega = 1.6e-2*3.14, pstart(displayUnit = "MPa") = 6e6, wnf = 0.5, wnm = 0.1, wnom = 81.6*3274/3275) annotation(
      Placement(transformation(origin = {-228, -48}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    ThermoPower.customModel.Models.RadialConduction1D Fuel_mixture_Avg(L = 8, Nr = 5, Nt = 3274, Nw = 20, Tstartbar = 1023.15, axialProfile = {0.04278298, 0.05092866, 0.05695018, 0.06107518, 0.06352006, 0.06449002, 0.06417902, 0.06276982, 0.06043394, 0.0573317, 0.05361218, 0.04941327, 0.04486162, 0.04007265, 0.03515058, 0.03018841, 0.02526791, 0.02045963, 0.01582291, 0.01140586}, lambda = 23.24, rext = 38e-3/2, rhomcm = 2341.42*1800, rint = 25.3e-3/2, useExternalHeatGen = true, useHeatGen = true) annotation(
      Placement(transformation(origin = {-194, -48}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
    ThermoPower.Gas.Flow1DFV coldDuct(A = 0.78, Dhyd = 0.41, DynamicMomentum = true, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Kfnom, Kfnom = 2, L = 5, redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He, N = 5, Nt = 1, Tstartbar = 598.15, dpnom(displayUnit = "Pa") = 3000, e = 0.00015, noInitialPressure = true, omega = 0.41*3.14, pstart(displayUnit = "MPa") = 6e6, wnf = 0.5, wnm = 0.1, wnom = 81.6) annotation(
      Placement(transformation(origin = {-188, -94}, extent = {{10, -10}, {-10, 10}})));
    ThermoPower.customModel.Models.Fan Blower(redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He, dp0(displayUnit = "Pa") = 1.8e5, redeclare function efficiencyCharacteristic = ThermoPower.Functions.PumpCharacteristics.constantEfficiency(eta_nom = 0.85), redeclare function flowCharacteristic = ThermoPower.Functions.FanCharacteristics.quadraticFlow(H_nom = {64854.44254405128, 37753.17324575091, 27333.29742992366}, q_nom = {0, 17.11477187140708, 22.249203432829205}), n0 = 1800, rho0(displayUnit = "kg/m3") = 4.77, use_in_n = true, w0 = 81.6) annotation(
      Placement(transformation(origin = {-162, -102}, extent = {{10, -10}, {-10, 10}})));
    ThermoPower.customModel.Models.RadialConduction1D Graphite_Avg(L = 8, Nr = 5, Nt = 3274, Nw = 20, Tstartbar = 1023.15, lambda = 23.6, rext = 25.3e-3/2, rhomcm = 1780*1979.2, rint = 16e-3/2, useExternalHeatGen = false, useHeatGen = false) annotation(
      Placement(transformation(origin = {-212, -48}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
    ThermoPower.Gas.Header lowerPlenum(redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He, Tmstart = 598.15, Tstart = 598.15, V = 62.59, pstart(displayUnit = "MPa") = 6e6) annotation(
      Placement(transformation(origin = {-318, -86}, extent = {{10, -10}, {-10, 10}})));
    ThermoPower.Gas.Header upperPlenum(redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He, Tmstart = 598.15, Tstart = 598.15, V = 53.88, pstart(displayUnit = "MPa") = 6e6) annotation(
      Placement(transformation(origin = {-282, 12}, extent = {{-10, -10}, {10, 10}})));
    ThermoPower.Electrical.PowerSensor sens_power annotation(
      Placement(transformation(origin = {164, -12}, extent = {{-10, 10}, {10, -10}})));
    ThermoPower.Gas.Flow1DFV Channel_Hot(A = 2e-4, Dhyd = 1.6e-2, DynamicMomentum = true, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Colebrook, redeclare model HeatTransfer = ThermoPower.Thermal.HeatTransferFV.DittusBoelter(Re_min = 700), L = 8, redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He, N = 21, Nt = 1, Tstartbar = 823.15, Tstartin = 598.15, Tstartout = 1023.15, dpnom = 1e5, e = 0.00015, omega = 1.6e-2*3.14, pstart(displayUnit = "MPa") = 6e6, wnf = 0.5, wnm = 0.1, wnom = 81.6*1/3275) annotation(
      Placement(transformation(origin = {-254, -48}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
    ThermoPower.customModel.Models.RadialConduction1D Fuel_mixture_Hot(L = 8, Nr = 5, Nt = 1, Nw = 20, Tstartbar = 1023.15, axialProfile = {0.04278298, 0.05092866, 0.05695018, 0.06107518, 0.06352006, 0.06449002, 0.06417902, 0.06276982, 0.06043394, 0.0573317, 0.05361218, 0.04941327, 0.04486162, 0.04007265, 0.03515058, 0.03018841, 0.02526791, 0.02045963, 0.01582291, 0.01140586}, lambda = 23.24, rext = 38e-3/2, rhomcm = 2341.42*1800, rint = 25.3e-3/2, useExternalHeatGen = true, useHeatGen = true) annotation(
      Placement(transformation(origin = {-286, -48}, extent = {{10, 10}, {-10, -10}}, rotation = 90)));
    ThermoPower.customModel.Models.RadialConduction1D Graphite_Hot(L = 8, Nr = 5, Nt = 1, Nw = 20, Tstartbar = 1023.15, lambda = 23.6, rext = 25.3e-3/2, rhomcm = 1780*1979.2, rint = 16e-3/2, useExternalHeatGen = false, useHeatGen = false) annotation(
      Placement(transformation(origin = {-270, -48}, extent = {{10, 10}, {-10, -10}}, rotation = 90)));
    ThermoPower.Water.ValveVap valve_turbine(CvData = ThermoPower.Choices.Valve.CvTypes.OpPoint, redeclare function FlowChar = ThermoPower.Functions.ValveCharacteristics.quadratic, dpnom(displayUnit = "Pa") = 5e5, pnom(displayUnit = "Pa") = 1.43e7, rhonom(displayUnit = "kg/m3") = 41.35, theta_fix = 0.85, thetanom = 0.85, useThetaInput = true, wnom = 69.08) annotation(
      Placement(transformation(origin = {-13, -5}, extent = {{-5, -5}, {5, 5}})));
    ThermoPower.Water.ValveVap valve_extraction(CvData = ThermoPower.Choices.Valve.CvTypes.OpPoint, redeclare function FlowChar = ThermoPower.Functions.ValveCharacteristics.quadratic, dpnom(displayUnit = "Pa") = 143000, pnom(displayUnit = "Pa") = 1.573e6, rhonom(displayUnit = "kg/m3") = 6.719, theta_fix = 0.5, thetanom = 0.5, useThetaInput = false, wnom = 15.079) annotation(
      Placement(transformation(origin = {53, -57}, extent = {{-5, 5}, {5, -5}}, rotation = -90)));
    ThermoPower.customModel.Models.ReactorPower reactorPower_Avg(P0 = 180e6/(3274 + 1.59)*3274, Tf0 = 943, Tm0 = 926, alpha_f = -4.2e-5, alpha_m = -8.55e-5, usePKE = true, useRhoExt = true, useTc = false, useTf = true, useTm = true, useXe = false) annotation(
      Placement(transformation(origin = {-196, 10}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Sources.Constant signal_constant(k = 1) annotation(
      Placement(transformation(origin = {-94, 124}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    ThermoPower.Gas.SensT1 sens_T_He(redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He) annotation(
      Placement(transformation(origin = {-128, 38}, extent = {{10, -10}, {-10, 10}})));
    ThermoPower.customModel.Blocks.LimPID_Tinit PID_reactivity(Ti = 50, controllerType = Modelica.Blocks.Types.SimpleController.PI, initType = Modelica.Blocks.Types.InitPID.InitialState, k = 0.5, u_m_nom = 1023, useInitTime = false, xi_start = 0/0.003, yMax = 50e-3, yMin = -50e-3, y_start = 0) annotation(
      Placement(transformation(origin = {-162, 44}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
    Modelica.Blocks.Math.Gain Gain_HotChannel(k = 1.59/3274) annotation(
      Placement(transformation(origin = {-244, 42}, extent = {{10, 10}, {-10, -10}})));
    ThermoPower.Water.SensP sens_P_steam annotation(
      Placement(transformation(origin = {-30, 20}, extent = {{10, -10}, {-10, 10}})));
    ThermoPower.customModel.Blocks.LimPID_Tinit PID_blower(Ti = 35, controllerType = Modelica.Blocks.Types.SimpleController.PI, initType = Modelica.Blocks.Types.InitPID.InitialState, k = 1.5, u_m_nom = 14.3e6, useInitTime = false, xi_start = 1/1.5, yMax = 1.2, yMin = 0.1, y_start = 1) annotation(
      Placement(transformation(origin = {-56, 50}, extent = {{10, -10}, {-10, 10}})));
    Modelica.Blocks.Math.Gain Gain_blower(k = 1800) annotation(
      Placement(transformation(origin = {-94, 50}, extent = {{10, 10}, {-10, -10}})));
    ThermoPower.Water.SensT1 sens_T_steam annotation(
      Placement(transformation(origin = {-4, 20}, extent = {{-10, -10}, {10, 10}})));
    ThermoPower.customModel.Blocks.LimPID_Tinit PID_fwpp(Ti = 35, controllerType = Modelica.Blocks.Types.SimpleController.PI, initType = Modelica.Blocks.Types.InitPID.InitialState, k = 1.5, u_s_nom = 823, useInitTime = false, xi_start = 1/1.5, yMax = 1.2, yMin = 0.1, y_start = 1) annotation(
      Placement(transformation(origin = {28, 26}, extent = {{-10, 10}, {10, -10}})));
    Modelica.Blocks.Math.Gain Gain_fwpp(k = 1800) annotation(
      Placement(transformation(origin = {64, 26}, extent = {{10, -10}, {-10, 10}}, rotation = -180)));
    ThermoPower.customModel.Models.Deaerator Deaerator(V = 25, pstart(displayUnit = "MPa") = 1.43e6) annotation(
      Placement(transformation(origin = {62, -92}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
    ThermoPower.customModel.Blocks.LimPID_Tinit PID_cdpp(Ti = 50, controllerType = Modelica.Blocks.Types.SimpleController.PI, initType = Modelica.Blocks.Types.InitPID.InitialState, k = 3.4, u_m_nom = 0.85, useInitTime = false, xi_start = 1/3.4, yMax = 1.2, yMin = 0.1, y_start = 1) annotation(
      Placement(transformation(origin = {142, -110}, extent = {{10, 10}, {-10, -10}})));
    Modelica.Blocks.Math.Gain Gain_cdpp(k = 1800) annotation(
      Placement(transformation(origin = {108, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    ThermoPower.customModel.Models.SteamTurbineStodolaEta HPTB(Kt = 0.00296, PRstart = 8.773, eta_iso_nom = 0.85, pnom(displayUnit = "MPa") = 1.38e7, useMflowCorrection = true, useWetnessCorrection = true, wnom = 69.08) annotation(
      Placement(transformation(origin = {26, -12}, extent = {{-10, -10}, {10, 10}})));
    ThermoPower.customModel.Models.SteamTurbineStodolaEta LPTB(Kt = 0.01661, PRstart = 78.65, eta_iso_nom = 0.85, pnom(displayUnit = "MPa") = 1.573e6, useMflowCorrection = true, useWetnessCorrection = true, wnom = 54.008) annotation(
      Placement(transformation(origin = {78, -12}, extent = {{-10, -10}, {10, 10}})));
    ThermoPower.customModel.Models.Grid_v grid_v(Pgrid = 65.5e6, pset_const = 65.5e6, use_in_pset = true) annotation(
      Placement(transformation(origin = {208, -12}, extent = {{-10, -10}, {10, 10}})));
    ThermoPower.customModel.Blocks.LimPID_Tinit PID_valve(Ti = 30, controllerType = Modelica.Blocks.Types.SimpleController.PI, initType = Modelica.Blocks.Types.InitPID.InitialState, k = 75, u_m_nom = 60, useInitTime = false, xi_start = 0.85/75, yMax = 1, yMin = 0.05, y_start = 1) annotation(
      Placement(transformation(origin = {200, 58}, extent = {{10, -10}, {-10, 10}})));
    ThermoPower.Electrical.FrequencySensor sens_frequency annotation(
      Placement(transformation(origin = {200, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    ThermoPower.Gas.Flow1DFV riser(A = 3.74, Dhyd = 0.54, DynamicMomentum = true, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Kfnom, Kfnom = 2, L = 8, redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He, N = 5, Nt = 1, Tstartbar = 598.15, dpnom(displayUnit = "Pa") = 3000, e = 0.00015, noInitialPressure = true, omega = 0.54*3.14, pstart(displayUnit = "MPa") = 6e6, wnf = 0.5, wnm = 0.1, wnom = 81.6) annotation(
      Placement(transformation(origin = {-342, -46}, extent = {{10, 10}, {-10, -10}}, rotation = -90)));
    Modelica.Blocks.Continuous.Derivative RhoDerivative(T = 0.1, initType = Modelica.Blocks.Types.Init.InitialState) annotation(
      Placement(transformation(origin = {-214, 82}, extent = {{10, -10}, {-10, 10}})));
    ThermoPower.customModel.Models.RadialConduction1D Graphite_Hot_Adjacent(L = 8, Nr = 5, Nt = 6, Nw = 20, Tstartbar = 1023.15, lambda = 23.6, rext = 38e-3/2*2, rhomcm = 1780*1979.2, rint = 38e-3/2, useExternalHeatGen = false, useHeatGen = false) annotation(
      Placement(transformation(origin = {-304, -48}, extent = {{10, 10}, {-10, -10}}, rotation = 90)));
    ThermoPower.Thermal.ConvHTFV conv_adjacent(G = 430*(2*3.14*16e-3/2*8)*6, Nv = 20) annotation(
      Placement(transformation(origin = {-274, -106}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    ThermoPower.Thermal.TempSource1DFV tempSource1DFV(Nw = 20) annotation(
      Placement(transformation(origin = {-254, -106}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Sources.Constant AvgTemp_constant(k = 1023) annotation(
      Placement(transformation(origin = {-226, -106}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Blocks.Sources.Sine LoadDemand(amplitude = 0.05, freqHz = 1, offset = 0.5, startTime = 3000) annotation(
      Placement(transformation(origin = {330, -8}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Blocks.Sources.Ramp ramp3(duration = 600, height = -0.5, offset = 1, startTime = 500) annotation(
      Placement(transformation(origin = {330, 54}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Blocks.Logical.Switch LoadDemand1 annotation(
      Placement(transformation(origin = {282, 18}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y = time < 3000) annotation(
      Placement(transformation(origin = {330, 18}, extent = {{10, -10}, {-10, 10}})));
  ThermoPower.customModel.Models.Condenser_ACC Condenser(cm = 500, condExchSurface = 4802.84, condNomFlowRate = 54.008, condNomPressure(displayUnit = "kPa") = 2e4, condVol = 26.415, coolExchSurface = 105837, coolNomFlowRate = 7433.86, coolNomPressure = 1e5, coolVol = 4157, gamma_cond = 15e3, gamma_cool = 42, metalVol = 141, pstart_cond(displayUnit = "kPa") = 2e4, rhoMetal(displayUnit = "kg/m3") = 8000) annotation(
    Placement(transformation(origin = {162, -54}, extent = {{-10, -10}, {10, 10}})));
  ThermoPower.Gas.SourceMassFlow sourceMassFlow(redeclare package Medium = Modelica.Media.Air.SimpleAir, T = 298.15, p0 = 1e5, w0 = 7433.86) annotation(
    Placement(transformation(origin = {198, -68}, extent = {{10, -10}, {-10, 10}})));
  ThermoPower.Gas.SinkPressure sinkPressure(redeclare package Medium = Modelica.Media.Air.SimpleAir, T = 313.15, p0 = 1e5) annotation(
    Placement(transformation(origin = {198, -42}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(economizer_secondary.outfl, evaporator_secondary.infl) annotation(
    Line(points = {{-30, -76}, {-30, -66}}, color = {0, 0, 255}));
  connect(evaporator_secondary.outfl, superheater_secondary.infl) annotation(
    Line(points = {{-30, -46}, {-30, -36}}, color = {0, 0, 255}));
  connect(counterCurrentFV.side1, econonmizer_wall.ext) annotation(
    Line(points = {{-83, -86}, {-59, -86}}, color = {255, 127, 0}));
  connect(economizer_primary.wall, counterCurrentFV.side2) annotation(
    Line(points = {{-123, -86}, {-89, -86}}, color = {255, 127, 0}));
  connect(econonmizer_wall.int, economizer_secondary.wall) annotation(
    Line(points = {{-53, -86}, {-34, -86}}, color = {255, 127, 0}));
  connect(counterCurrentFV1.side1, evaporator_wall.ext) annotation(
    Line(points = {{-83, -56}, {-59, -56}}, color = {255, 127, 0}));
  connect(counterCurrentFV2.side1, superheater_wall.ext) annotation(
    Line(points = {{-83, -26}, {-59, -26}}, color = {255, 127, 0}));
  connect(evaporator_primary.wall, counterCurrentFV1.side2) annotation(
    Line(points = {{-123, -56}, {-89, -56}}, color = {255, 127, 0}));
  connect(evaporator_wall.int, evaporator_secondary.wall) annotation(
    Line(points = {{-53, -56}, {-35, -56}}, color = {255, 127, 0}));
  connect(superheater_primary.wall, counterCurrentFV2.side2) annotation(
    Line(points = {{-123, -26}, {-89, -26}}, color = {255, 127, 0}));
  connect(superheater_wall.int, superheater_secondary.wall) annotation(
    Line(points = {{-53, -26}, {-35, -26}}, color = {255, 127, 0}));
  connect(superheater_primary.outfl, evaporator_primary.infl) annotation(
    Line(points = {{-128, -36}, {-128, -46}}, color = {159, 159, 223}));
  connect(evaporator_primary.outfl, economizer_primary.infl) annotation(
    Line(points = {{-128, -66}, {-128, -76}}, color = {159, 159, 223}));
  connect(Graphite_Avg.int, Channel_Avg.wall) annotation(
    Line(points = {{-215, -48}, {-223, -48}}, color = {255, 127, 0}));
  connect(Fuel_mixture_Avg.int, Graphite_Avg.ext) annotation(
    Line(points = {{-197, -48}, {-210, -48}}, color = {255, 127, 0}));
  connect(Blower.infl, economizer_primary.outfl) annotation(
    Line(points = {{-154, -99.8}, {-154, -95.8}, {-128, -95.8}}, color = {159, 159, 223}));
  connect(coldDuct.infl, Blower.outfl) annotation(
    Line(points = {{-178, -94}, {-178, -95}, {-168, -95}}, color = {159, 159, 223}));
  connect(hotDuct.outfl, superheater_primary.infl) annotation(
    Line(points = {{-178, -74}, {-156, -74}, {-156, 0}, {-128, 0}, {-128, -16}}, color = {159, 159, 223}));
  connect(coldDuct.outfl, lowerPlenum.inlet) annotation(
    Line(points = {{-198, -94}, {-218, -94}, {-218, -86}, {-308, -86}}, color = {159, 159, 223}));
  connect(economizer_secondary.infl, FwPump.outfl) annotation(
    Line(points = {{-30, -96}, {-28, -96}, {-28, -117}, {4, -117}}, color = {0, 0, 255}));
  connect(generator.port, sens_power.port_a) annotation(
    Line(points = {{140.6, -12}, {153.6, -12}}, color = {0, 0, 255}));
  connect(Fuel_mixture_Hot.int, Graphite_Hot.ext) annotation(
    Line(points = {{-283, -48}, {-274, -48}}, color = {255, 127, 0}));
  connect(Graphite_Hot.int, Channel_Hot.wall) annotation(
    Line(points = {{-267, -48}, {-258, -48}}, color = {255, 127, 0}));
  connect(upperPlenum.outlet, Channel_Hot.infl) annotation(
    Line(points = {{-272, 12}, {-254, 12}, {-254, -38}}, color = {159, 159, 223}));
  connect(upperPlenum.outlet, Channel_Avg.infl) annotation(
    Line(points = {{-272, 12}, {-228, 12}, {-228, -38}}, color = {159, 159, 223}));
  connect(Channel_Avg.outfl, hotDuct.infl) annotation(
    Line(points = {{-228, -58}, {-228, -74}, {-198, -74}}, color = {159, 159, 223}));
  connect(Channel_Hot.outfl, hotDuct.infl) annotation(
    Line(points = {{-254, -58}, {-254, -74}, {-198, -74}}, color = {159, 159, 223}));
  connect(superheater_secondary.outfl, valve_turbine.inlet) annotation(
    Line(points = {{-30, -16}, {-30, -5}, {-18, -5}}, color = {0, 0, 255}));
  connect(flowSplit.out1, valve_extraction.inlet) annotation(
    Line(points = {{53, -28}, {53, -52}}, color = {0, 0, 255}));
  connect(superheater_primary.infl, sens_T_He.flange) annotation(
    Line(points = {{-128, -16}, {-128, 34}}, color = {159, 159, 223}));
  connect(sens_T_He.T, PID_reactivity.u_m) annotation(
    Line(points = {{-135, 44}, {-151, 44}}, color = {0, 0, 127}));
  connect(signal_constant.y, PID_reactivity.u_s) annotation(
    Line(points = {{-94, 113}, {-94, 85}, {-162, 85}, {-162, 55}}, color = {0, 0, 127}));
  connect(PID_reactivity.y, reactorPower_Avg.rho_ext) annotation(
    Line(points = {{-162, 33}, {-162, 24}, {-220, 24}, {-220, 10}, {-204, 10}}, color = {0, 0, 127}));
  connect(Fuel_mixture_Avg.Tm_avg, reactorPower_Avg.Tf) annotation(
    Line(points = {{-196, -37.8}, {-202, -37.8}, {-202, 2.2}}, color = {0, 0, 127}));
  connect(Graphite_Avg.Tm_avg, reactorPower_Avg.Tm) annotation(
    Line(points = {{-214, -37.8}, {-214, -19.8}, {-196, -19.8}, {-196, 2.2}}, color = {0, 0, 127}));
  connect(reactorPower_Avg.Power, Fuel_mixture_Avg.heatGenInput) annotation(
    Line(points = {{-187, 10}, {-177, 10}, {-177, -26}, {-193, -26}, {-193, -38}}, color = {0, 0, 127}));
  connect(reactorPower_Avg.Power, Gain_HotChannel.u) annotation(
    Line(points = {{-187, 10}, {-185, 10}, {-185, 42}, {-233, 42}}, color = {0, 0, 127}));
  connect(Gain_HotChannel.y, Fuel_mixture_Hot.heatGenInput) annotation(
    Line(points = {{-255, 42}, {-317, 42}, {-317, -24}, {-289, -24}, {-289, -38}}, color = {0, 0, 127}));
  connect(superheater_secondary.outfl, sens_P_steam.flange) annotation(
    Line(points = {{-30, -16}, {-30, 16}}, color = {0, 0, 255}));
  connect(sens_P_steam.p, PID_blower.u_m) annotation(
    Line(points = {{-38, 26}, {-56, 26}, {-56, 38}}, color = {0, 0, 127}));
  connect(signal_constant.y, PID_blower.u_s) annotation(
    Line(points = {{-94, 113}, {-94, 85}, {-32, 85}, {-32, 49}, {-44, 49}}, color = {0, 0, 127}));
  connect(PID_blower.y, Gain_blower.u) annotation(
    Line(points = {{-67, 50}, {-83, 50}}, color = {0, 0, 127}));
  connect(Gain_blower.y, Blower.in_n) annotation(
    Line(points = {{-105, 50}, {-111, 50}, {-111, 8}, {-163, 8}, {-163, -94}}, color = {0, 0, 127}));
  connect(superheater_secondary.outfl, sens_T_steam.flange) annotation(
    Line(points = {{-30, -16}, {-30, 4}, {-4, 4}, {-4, 16}}, color = {0, 0, 255}));
  connect(sens_T_steam.T, PID_fwpp.u_s) annotation(
    Line(points = {{4, 26}, {16, 26}}, color = {0, 0, 127}));
  connect(signal_constant.y, PID_fwpp.u_m) annotation(
    Line(points = {{-94, 113}, {-94, 85}, {28, 85}, {28, 37}}, color = {0, 0, 127}));
  connect(PID_fwpp.y, Gain_fwpp.u) annotation(
    Line(points = {{39, 26}, {51, 26}}, color = {0, 0, 127}));
  connect(Gain_fwpp.y, FwPump.in_n) annotation(
    Line(points = {{75, 26}, {99, 26}, {99, -40}, {11, -40}, {11, -116}}, color = {0, 0, 127}));
  connect(valve_extraction.outlet, Deaerator.SteamIn) annotation(
    Line(points = {{53, -62}, {56, -62}, {56, -84}}, color = {0, 0, 255}));
  connect(CdPump.outfl, Deaerator.WaterIn) annotation(
    Line(points = {{100, -75}, {98, -75}, {98, -65}, {68, -65}, {68, -85}}, color = {0, 0, 255}));
  connect(Deaerator.CondOut, FwPump.infl) annotation(
    Line(points = {{62, -102}, {62, -122}, {18, -122}}, color = {0, 0, 255}));
  connect(signal_constant.y, PID_cdpp.u_s) annotation(
    Line(points = {{-94, 113}, {-94, 85}, {264, 85}, {264, -111}, {154, -111}}, color = {0, 0, 127}));
  connect(PID_cdpp.y, Gain_cdpp.u) annotation(
    Line(points = {{131, -110}, {119, -110}}, color = {0, 0, 127}));
  connect(Gain_cdpp.y, CdPump.in_n) annotation(
    Line(points = {{97, -110}, {83, -110}, {83, -60}, {107, -60}, {107, -74}}, color = {0, 0, 127}));
  connect(valve_turbine.outlet, HPTB.inlet) annotation(
    Line(points = {{-8, -5}, {5, -5}, {5, -4}, {18, -4}}, color = {0, 0, 255}));
  connect(HPTB.outlet, flowSplit.in1) annotation(
    Line(points = {{34, -4}, {34, -22}, {56, -22}}, color = {0, 0, 255}));
  connect(flowSplit.out2, LPTB.inlet) annotation(
    Line(points = {{57, -28}, {63, -28}, {63, -4}, {69, -4}}, color = {0, 0, 255}));
  connect(HPTB.shaft_b, LPTB.shaft_a) annotation(
    Line(points = {{32.4, -12}, {71.4, -12}}));
  connect(LPTB.shaft_b, generator.shaft) annotation(
    Line(points = {{84.4, -12}, {124.4, -12}}));
  connect(grid_v.port, sens_power.port_b) annotation(
    Line(points = {{199.4, -12}, {174.4, -12}}, color = {0, 0, 255}));
  connect(PID_valve.y, valve_turbine.theta) annotation(
    Line(points = {{189, 58}, {114, 58}, {114, 2}, {-12, 2}, {-12, 0}}, color = {0, 0, 127}));
  connect(grid_v.port, sens_frequency.port) annotation(
    Line(points = {{199.4, -12}, {199.4, 8}}, color = {0, 0, 255}));
  connect(signal_constant.y, PID_valve.u_s) annotation(
    Line(points = {{-94, 113}, {-94, 85}, {232, 85}, {232, 57}, {212, 57}}, color = {0, 0, 127}));
  connect(sens_frequency.f, PID_valve.u_m) annotation(
    Line(points = {{200, 28.2}, {200, 46.2}}, color = {0, 0, 127}));
  connect(lowerPlenum.outlet, riser.infl) annotation(
    Line(points = {{-328, -86}, {-342, -86}, {-342, -56}}, color = {159, 159, 223}));
  connect(riser.outfl, upperPlenum.inlet) annotation(
    Line(points = {{-342, -36}, {-340, -36}, {-340, 12}, {-292, 12}}, color = {159, 159, 223}));
  connect(PID_reactivity.y, RhoDerivative.u) annotation(
    Line(points = {{-162, 33}, {-162, 23}, {-192, 23}, {-192, 81}, {-202, 81}}, color = {0, 0, 127}));
  connect(Graphite_Hot_Adjacent.int, Fuel_mixture_Hot.ext) annotation(
    Line(points = {{-301, -48}, {-291, -48}}, color = {255, 127, 0}));
  connect(Graphite_Hot_Adjacent.ext, conv_adjacent.side2) annotation(
    Line(points = {{-307.1, -48}, {-319.1, -48}, {-319.1, -74}, {-289.1, -74}, {-289.1, -106}, {-277.1, -106}}, color = {255, 127, 0}));
  connect(tempSource1DFV.wall, conv_adjacent.side1) annotation(
    Line(points = {{-257, -106}, {-271, -106}}, color = {255, 127, 0}));
  connect(AvgTemp_constant.y, tempSource1DFV.temperature) annotation(
    Line(points = {{-237, -106}, {-251, -106}}, color = {0, 0, 127}));
  connect(gain.y, grid_v.pset) annotation(
    Line(points = {{230, 18}, {214, 18}, {214, 4}, {206, 4}, {206, -4}}, color = {0, 0, 127}));
  connect(ramp3.y, LoadDemand1.u1) annotation(
    Line(points = {{319, 54}, {306, 54}, {306, 26}, {294, 26}}, color = {0, 0, 127}));
  connect(booleanExpression.y, LoadDemand1.u2) annotation(
    Line(points = {{319, 18}, {294, 18}}, color = {255, 0, 255}));
  connect(LoadDemand.y, LoadDemand1.u3) annotation(
    Line(points = {{319, -8}, {303, -8}, {303, 10}, {293, 10}}, color = {0, 0, 127}));
  connect(LoadDemand1.y, gain.u) annotation(
    Line(points = {{272, 18}, {252, 18}}, color = {0, 0, 127}));
  connect(LPTB.outlet, Condenser.steamIn) annotation(
    Line(points = {{86, -4}, {114, -4}, {114, -30}, {161, -30}, {161, -44}}, color = {0, 0, 255}));
  connect(Condenser.waterOut, CdPump.infl) annotation(
    Line(points = {{162, -64}, {162, -80}, {114, -80}}, color = {0, 0, 255}));
  connect(Condenser.ratio_VvonVtot, PID_cdpp.u_m) annotation(
    Line(points = {{152, -52}, {142, -52}, {142, -98}}, color = {0, 0, 127}));
  connect(sourceMassFlow.flange, Condenser.coolingIn) annotation(
    Line(points = {{188, -68}, {180, -68}, {180, -58}, {172, -58}}, color = {159, 159, 223}));
  connect(Condenser.coolingOut, sinkPressure.flange) annotation(
    Line(points = {{172, -48}, {178, -48}, {178, -42}, {188, -42}}, color = {159, 159, 223}));
  annotation(
      experiment(StartTime = 0, StopTime = 3450, Tolerance = 1e-06, Interval = 2),
      Documentation(info = "<HTML>
  <p><b>PID version of frequency-amplitude analysis.</b><p>
  <p>Reach and maintain 50% of power until 3000s, after which sine wave is given.<p.
  </ul>
  </html>"));
  end freq_amp_PID;