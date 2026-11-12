within ReferenceOM.TransientRuns;

model BaseLoad_SMC "Reference base load model with SMC controller. Compatible with v0.25"
  ThermoPower.Water.Flow1DFV2ph economizer_secondary(A = 0.0001337, Dhyd = 13.05e-3, DynamicMomentum = true, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Colebrook, FluidPhaseStart = ThermoPower.Choices.FluidPhase.FluidPhases.Liquid, redeclare model HeatTransfer = ThermoPower.Thermal.HeatTransferFV.DittusBoelter, Kfc = 2, L = 12.9, N = 10, Nt = 359, dpnom(displayUnit = "kPa") = 176000, e = 0.00015, hstartin = 856795, hstartout = 1559329, noInitialPressure = false, omega = 0.041, pstart(displayUnit = "MPa") = 1.45e7, wnf = 0.5, wnm = 0.1, wnom = 69.08) annotation(
    Placement(transformation(origin = {-218, -38}, extent = {{10, 10}, {-10, -10}}, rotation = -90)));
  ThermoPower.Water.Flow1DFV2ph evaporator_secondary(A = 0.0001337, Dhyd = 13.05e-3, DynamicMomentum = true, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Colebrook, FluidPhaseStart = ThermoPower.Choices.FluidPhase.FluidPhases.TwoPhases, redeclare model HeatTransfer = ThermoPower.Thermal.HeatTransferFV.DittusBoelter, Kfc = 2, L = 10.2, N = 10, Nt = 359, dpnom(displayUnit = "kPa") = 143000, e = 0.00015, hstartin = 1575931, hstartout = 2611643, noInitialPressure = false, omega = 0.041, pstart(displayUnit = "MPa") = 1.44e7, wnf = 0.5, wnm = 0.1, wnom = 69.08) annotation(
    Placement(transformation(origin = {-218, -8}, extent = {{10, 10}, {-10, -10}}, rotation = -90)));
  ThermoPower.Water.Flow1DFV2ph superheater_secondary(A = 0.0001337, Dhyd = 13.05e-3, DynamicMomentum = true, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Colebrook, FluidPhaseStart = ThermoPower.Choices.FluidPhase.FluidPhases.Steam, redeclare model HeatTransfer = ThermoPower.Thermal.HeatTransferFV.DittusBoelter, Kfc = 2, L = 6.9, N = 10, Nt = 359, dpnom(displayUnit = "kPa") = 9e4, e = 0.00015, hstartin = 2660669, hstartout = 3430465, noInitialPressure = false, omega = 0.041, pstart(displayUnit = "MPa") = 1.43e7, wnf = 0.5, wnm = 0.1, wnom = 69.08) annotation(
    Placement(transformation(origin = {-218, 22}, extent = {{10, 10}, {-10, -10}}, rotation = -90)));
  ThermoPower.Gas.Flow1DFV economizer_primary(A = 3.06, Dhyd = 19.05e-3, DynamicMomentum = true, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Kfnom, redeclare model HeatTransfer = ThermoPower.customModel.Models.ZukauskasInLineHTC(pt_OD = 1.5), Kfnom = 27, L = 12.9, redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He, N = 10, Nt = 1, Tstartbar = 650.15, dpnom = 1e5, e = 0.00015, omega = 21.457, pstart(displayUnit = "MPa") = 6e6, wnf = 0.1, wnm = 0.1, wnom = 81.6) annotation(
    Placement(transformation(origin = {-316, -38}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  ThermoPower.Gas.Flow1DFV evaporator_primary(A = 3.06, Dhyd = 19.05e-3, DynamicMomentum = true, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Kfnom, redeclare model HeatTransfer = ThermoPower.customModel.Models.ZukauskasInLineHTC(pt_OD = 1.5), Kfnom = 27, L = 10.2, redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He, N = 10, Nt = 1, Tstartbar = 770.15, dpnom = 1e5, e = 0.00015, omega = 21.457, pstart(displayUnit = "MPa") = 6e6, wnf = 0.1, wnm = 0.1, wnom = 81.6) annotation(
    Placement(transformation(origin = {-316, -8}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  ThermoPower.Gas.Flow1DFV superheater_primary(A = 3.06, Dhyd = 19.05e-3, DynamicMomentum = true, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Kfnom, redeclare model HeatTransfer = ThermoPower.customModel.Models.ZukauskasInLineHTC(pt_OD = 1.5), Kfnom = 27, L = 6.9, redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He, N = 10, Nt = 1, Tstartbar = 1023.15, dpnom = 1e5, e = 0.00015, omega = 21.457, pstart(displayUnit = "MPa") = 6e6, wnf = 0.1, wnm = 0.1, wnom = 81.6) annotation(
    Placement(transformation(origin = {-316, 22}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  ThermoPower.Thermal.MetalTubeFV econonmizer_wall(L = 12.9, Nt = 359, Nw = 9, Tstartbar = 623.15, lambda = 22, rext = 19.05e-3/2, rhomcm = 4000000, rint = 13.05e-3/2) annotation(
    Placement(transformation(origin = {-244, -38}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  ThermoPower.Thermal.CounterCurrentFV counterCurrentFV(Nw = 9) annotation(
    Placement(transformation(origin = {-274, -38}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  ThermoPower.Thermal.MetalTubeFV evaporator_wall(L = 10.2, Nt = 359, Nw = 9, Tstartbar = 723.15, lambda = 22, rext = 19.05e-3/2, rhomcm = 4000000, rint = 13.05e-3/2) annotation(
    Placement(transformation(origin = {-244, -8}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  ThermoPower.Thermal.CounterCurrentFV counterCurrentFV1(Nw = 9) annotation(
    Placement(transformation(origin = {-274, -8}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  ThermoPower.Thermal.MetalTubeFV superheater_wall(L = 6.9, Nt = 359, Nw = 9, Tstartbar = 873.15, lambda = 22, rext = 19.05e-3/2, rhomcm = 4000000, rint = 13.05e-3/2) annotation(
    Placement(transformation(origin = {-244, 22}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  ThermoPower.Thermal.CounterCurrentFV counterCurrentFV2(Nw = 9) annotation(
    Placement(transformation(origin = {-274, 22}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  inner ThermoPower.System system(allowFlowReversal = false, fnom = 60, initOpt = ThermoPower.Choices.Init.Options.fixedState) annotation(
    Placement(transformation(origin = {-172, 166}, extent = {{-10, -10}, {10, 10}})));
  ThermoPower.Electrical.Generator generator(Np = 1, Pnom(displayUnit = "MW") = 6.55e7, fstart = 60, referenceGenerator = true) annotation(
    Placement(transformation(origin = {-56, 36}, extent = {{-10, -10}, {10, 10}})));
  ThermoPower.Water.FlowSplit flowSplit annotation(
    Placement(transformation(origin = {-133, 23}, extent = {{-5, 5}, {5, -5}}, rotation = -90)));
  ThermoPower.Water.Pump CdPump(dp0(displayUnit = "MPa") = 1.41e6, redeclare function efficiencyCharacteristic = ThermoPower.Functions.PumpCharacteristics.constantEfficiency(eta_nom = 0.85), redeclare function flowCharacteristic = ThermoPower.Functions.PumpCharacteristics.quadraticFlow(head_nom = {300.72743947238007, 146.23388533741434, 105.87333298428797}, q_nom = {0, 0.054870609296703905, 0.07133179208571508}), hstart = 193516, n0 = 1800, rho0(displayUnit = "kg/m3") = 983.13, use_in_n = true, w0 = 54.008) annotation(
    Placement(transformation(origin = {-82, -34}, extent = {{10, -10}, {-10, 10}})));
  ThermoPower.Water.Pump FwPump(dp0(displayUnit = "MPa") = 1.3312e7, redeclare function efficiencyCharacteristic = ThermoPower.Functions.PumpCharacteristics.constantEfficiency(eta_nom = 0.85), redeclare function flowCharacteristic = ThermoPower.Functions.PumpCharacteristics.quadraticFlow(head_nom = {3085.5366742612923, 1561.0976244723518, 1130.2346801179826}, q_nom = {0, 0.07947880436649801, 0.10332244567644742}), hstart = 856795, n0 = 1800, rho0(displayUnit = "kg/m3") = 869.24, use_in_n = true, w0 = 69.08) annotation(
    Placement(transformation(origin = {-178, -76}, extent = {{10, -10}, {-10, 10}})));
  ThermoPower.Gas.Flow1DFV hotDuct(A = 0.78, Dhyd = 1, DynamicMomentum = true, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Kfnom, Kfnom = 2, L = 5, redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He, N = 5, Nt = 1, Tstartbar = 1023.15, dpnom(displayUnit = "Pa") = 3000, e = 0.00015, omega = 1*3.14, pstart(displayUnit = "MPa") = 6e6, wnf = 0.5, wnm = 0.1, wnom = 81.6) annotation(
    Placement(transformation(origin = {-376, -26}, extent = {{-10, -10}, {10, 10}})));
  ThermoPower.Gas.Flow1DFV Channel_Avg(A = 2e-4, Dhyd = 1.6e-2, DynamicMomentum = true, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Colebrook, redeclare model HeatTransfer = ThermoPower.Thermal.HeatTransferFV.DittusBoelter(Re_min = 700), L = 8, redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He, N = 21, Nt = 3274, Tstartbar = 823.15, Tstartin = 598.15, Tstartout = 1023.15, dpnom = 1e5, e = 0.00015, noInitialPressure = true, omega = 1.6e-2*3.14, pstart(displayUnit = "MPa") = 6e6, wnf = 0.5, wnm = 0.1, wnom = 81.6*3274/3275) annotation(
    Placement(transformation(origin = {-416, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  ThermoPower.customModel.Models.RadialConduction1D Fuel_mixture_Avg(L = 8, Nr = 5, Nt = 3274, Nw = 20, Tstartbar = 1023.15, axialProfile = {0.04278298, 0.05092866, 0.05695018, 0.06107518, 0.06352006, 0.06449002, 0.06417902, 0.06276982, 0.06043394, 0.0573317, 0.05361218, 0.04941327, 0.04486162, 0.04007265, 0.03515058, 0.03018841, 0.02526791, 0.02045963, 0.01582291, 0.01140586}, lambda = 23.24, rext = 38e-3/2, rhomcm = 2341.42*1800, rint = 25.3e-3/2, useExternalHeatGen = true, useHeatGen = true) annotation(
    Placement(transformation(origin = {-382, 0}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
  ThermoPower.Gas.Flow1DFV coldDuct(A = 0.78, Dhyd = 0.41, DynamicMomentum = true, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Kfnom, Kfnom = 2, L = 5, redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He, N = 5, Nt = 1, Tstartbar = 598.15, dpnom(displayUnit = "Pa") = 3000, e = 0.00015, noInitialPressure = true, omega = 0.41*3.14, pstart(displayUnit = "MPa") = 6e6, wnf = 0.5, wnm = 0.1, wnom = 81.6) annotation(
    Placement(transformation(origin = {-376, -46}, extent = {{10, -10}, {-10, 10}})));
  ThermoPower.customModel.Models.Fan Blower(redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He, dp0(displayUnit = "Pa") = 1.8e5, redeclare function efficiencyCharacteristic = ThermoPower.Functions.PumpCharacteristics.constantEfficiency(eta_nom = 0.85), redeclare function flowCharacteristic = ThermoPower.Functions.FanCharacteristics.quadraticFlow(H_nom = {64854.44254405128, 37753.17324575091, 27333.29742992366}, q_nom = {0, 17.11477187140708, 22.249203432829205}), n0 = 1800, rho0(displayUnit = "kg/m3") = 4.77, use_in_n = true, w0 = 81.6) annotation(
    Placement(transformation(origin = {-350, -54}, extent = {{10, -10}, {-10, 10}})));
  ThermoPower.customModel.Models.RadialConduction1D Graphite_Avg(L = 8, Nr = 5, Nt = 3274, Nw = 20, Tstartbar = 1023.15, lambda = 23.6, rext = 25.3e-3/2, rhomcm = 1780*1979.2, rint = 16e-3/2, useExternalHeatGen = false, useHeatGen = false) annotation(
    Placement(transformation(origin = {-400, 0}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
  ThermoPower.Gas.Header lowerPlenum(redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He, Tmstart = 598.15, Tstart = 598.15, V = 62.59, pstart(displayUnit = "MPa") = 6e6) annotation(
    Placement(transformation(origin = {-506, -38}, extent = {{10, -10}, {-10, 10}})));
  ThermoPower.Gas.Header upperPlenum(redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He, Tmstart = 598.15, Tstart = 598.15, V = 53.88, pstart(displayUnit = "MPa") = 6e6) annotation(
    Placement(transformation(origin = {-470, 60}, extent = {{-10, -10}, {10, 10}})));
  ThermoPower.Electrical.PowerSensor sens_power annotation(
    Placement(transformation(origin = {-24, 36}, extent = {{-10, 10}, {10, -10}})));
  ThermoPower.Gas.Flow1DFV Channel_Hot(A = 2e-4, Dhyd = 1.6e-2, DynamicMomentum = true, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Colebrook, redeclare model HeatTransfer = ThermoPower.Thermal.HeatTransferFV.DittusBoelter(Re_min = 700), L = 8, redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He, N = 21, Nt = 1, Tstartbar = 823.15, Tstartin = 598.15, Tstartout = 1023.15, dpnom = 1e5, e = 0.00015, omega = 1.6e-2*3.14, pstart(displayUnit = "MPa") = 6e6, wnf = 0.5, wnm = 0.1, wnom = 81.6*1/3275) annotation(
    Placement(transformation(origin = {-442, 0}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
  ThermoPower.customModel.Models.RadialConduction1D Fuel_mixture_Hot(L = 8, Nr = 5, Nt = 1, Nw = 20, Tstartbar = 1023.15, axialProfile = {0.04278298, 0.05092866, 0.05695018, 0.06107518, 0.06352006, 0.06449002, 0.06417902, 0.06276982, 0.06043394, 0.0573317, 0.05361218, 0.04941327, 0.04486162, 0.04007265, 0.03515058, 0.03018841, 0.02526791, 0.02045963, 0.01582291, 0.01140586}, lambda = 23.24, rext = 38e-3/2, rhomcm = 2341.42*1800, rint = 25.3e-3/2, useExternalHeatGen = true, useHeatGen = true) annotation(
    Placement(transformation(origin = {-474, 0}, extent = {{10, 10}, {-10, -10}}, rotation = 90)));
  ThermoPower.customModel.Models.RadialConduction1D Graphite_Hot(L = 8, Nr = 5, Nt = 1, Nw = 20, Tstartbar = 1023.15, lambda = 23.6, rext = 25.3e-3/2, rhomcm = 1780*1979.2, rint = 16e-3/2, useExternalHeatGen = false, useHeatGen = false) annotation(
    Placement(transformation(origin = {-458, 0}, extent = {{10, 10}, {-10, -10}}, rotation = 90)));
  ThermoPower.Water.ValveVap valve_turbine(CvData = ThermoPower.Choices.Valve.CvTypes.OpPoint, redeclare function FlowChar = ThermoPower.Functions.ValveCharacteristics.quadratic, dpnom(displayUnit = "Pa") = 5e5, pnom(displayUnit = "Pa") = 1.43e7, rhonom(displayUnit = "kg/m3") = 41.35, theta_fix = 0.85, thetanom = 0.85, useThetaInput = true, wnom = 69.08) annotation(
    Placement(transformation(origin = {-201, 43}, extent = {{-5, -5}, {5, 5}})));
  ThermoPower.Water.ValveVap valve_extraction(CvData = ThermoPower.Choices.Valve.CvTypes.OpPoint, redeclare function FlowChar = ThermoPower.Functions.ValveCharacteristics.quadratic, dpnom(displayUnit = "Pa") = 143000, pnom(displayUnit = "Pa") = 1.573e6, rhonom(displayUnit = "kg/m3") = 6.719, theta_fix = 0.5, thetanom = 0.5, useThetaInput = false, wnom = 15.079) annotation(
    Placement(transformation(origin = {-135, -9}, extent = {{-5, 5}, {5, -5}}, rotation = -90)));
  ThermoPower.customModel.Models.ReactorPower reactorPower_Avg(P0 = 180e6/(3274 + 1.59)*3274, Tf0 = 943, Tm0 = 926, alpha_f = -4.2e-5, alpha_m = -8.55e-5, usePKE = true, useRhoExt = true, useTc = false, useTf = true, useTm = true, useXe = true) annotation(
    Placement(transformation(origin = {-384, 58}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Constant signal_constant(k = 1) annotation(
    Placement(transformation(origin = {-282, 172}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  ThermoPower.Gas.SensT1 sens_T_He(redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He) annotation(
    Placement(transformation(origin = {-316, 86}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Blocks.Math.Gain Gain_HotChannel(k = 1.59/3274) annotation(
    Placement(transformation(origin = {-432, 90}, extent = {{10, 10}, {-10, -10}})));
  ThermoPower.Water.SensP sens_P_steam annotation(
    Placement(transformation(origin = {-218, 68}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Blocks.Math.Gain Gain_blower(k = 1800) annotation(
    Placement(transformation(origin = {-282, 98}, extent = {{10, 10}, {-10, -10}})));
  ThermoPower.Water.SensT1 sens_T_steam annotation(
    Placement(transformation(origin = {-192, 68}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.Gain Gain_fwpp(k = 1800) annotation(
    Placement(transformation(origin = {-108, 72}, extent = {{10, -10}, {-10, 10}}, rotation = -180)));
  ThermoPower.customModel.Models.Deaerator Deaerator(V = 25, pstart(displayUnit = "MPa") = 1.43e6) annotation(
    Placement(transformation(origin = {-126, -44}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
  Modelica.Blocks.Math.Gain Gain_cdpp(k = 1800) annotation(
    Placement(transformation(origin = {-80, -62}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  ThermoPower.customModel.Models.SteamTurbineStodolaEta HPTB(Kt = 0.00296, PRstart = 8.773, eta_iso_nom = 0.85, pnom(displayUnit = "MPa") = 1.38e7, useMflowCorrection = true, useWetnessCorrection = true, wnom = 69.08) annotation(
    Placement(transformation(origin = {-162, 36}, extent = {{-10, -10}, {10, 10}})));
  ThermoPower.customModel.Models.SteamTurbineStodolaEta LPTB(Kt = 0.01661, PRstart = 78.65, eta_iso_nom = 0.85, pnom(displayUnit = "MPa") = 1.573e6, useMflowCorrection = true, useWetnessCorrection = true, wnom = 54.008) annotation(
    Placement(transformation(origin = {-110, 36}, extent = {{-10, -10}, {10, 10}})));
  ThermoPower.customModel.Models.Grid_v grid_v(Pgrid(displayUnit = "W") = 65.5e6, pset_const = 65.5e6, use_in_pset = true) annotation(
    Placement(transformation(origin = {20, 36}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.Gain gain(k = 65.5e6) annotation(
    Placement(transformation(origin = {54, 52}, extent = {{10, -10}, {-10, 10}})));
  ThermoPower.Electrical.FrequencySensor sens_frequency annotation(
    Placement(transformation(origin = {12, 66}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  ThermoPower.Gas.Flow1DFV riser(A = 3.74, Dhyd = 0.54, DynamicMomentum = true, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Kfnom, Kfnom = 2, L = 8, redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He, N = 5, Nt = 1, Tstartbar = 598.15, dpnom(displayUnit = "Pa") = 3000, e = 0.00015, noInitialPressure = true, omega = 0.54*3.14, pstart(displayUnit = "MPa") = 6e6, wnf = 0.5, wnm = 0.1, wnom = 81.6) annotation(
    Placement(transformation(origin = {-530, 2}, extent = {{10, 10}, {-10, -10}}, rotation = -90)));
  Modelica.Blocks.Continuous.Derivative RhoDerivative(T = 0.1, initType = Modelica.Blocks.Types.Init.InitialState) annotation(
    Placement(transformation(origin = {-412, 132}, extent = {{10, -10}, {-10, 10}})));
  ThermoPower.customModel.Models.RadialConduction1D Graphite_Hot_Adjacent(L = 8, Nr = 5, Nt = 6, Nw = 20, Tstartbar = 1023.15, lambda = 23.6, rext = 38e-3/2*2, rhomcm = 1780*1979.2, rint = 38e-3/2, useExternalHeatGen = false, useHeatGen = false) annotation(
    Placement(transformation(origin = {-492, 0}, extent = {{10, 10}, {-10, -10}}, rotation = 90)));
  ThermoPower.Thermal.ConvHTFV conv_adjacent(G = 430*(2*3.14*16e-3/2*8)*6, Nv = 20) annotation(
    Placement(transformation(origin = {-462, -58}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  ThermoPower.Thermal.TempSource1DFV tempSource1DFV(Nw = 20) annotation(
    Placement(transformation(origin = {-442, -58}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Sources.Constant AvgTemp_constant(k = 1023) annotation(
    Placement(transformation(origin = {-414, -58}, extent = {{10, -10}, {-10, 10}})));
  ThermoPower.customModel.Blocks.SuperTwistingSMC SMC_reactivity(T_C = 5, alpha = 5e-5, c = 1, lambda = 0.1, phi_lambda = 0.01, w_start = 0) annotation(
    Placement(transformation(origin = {-370, 114}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
  Modelica.Blocks.Math.Gain Norm_reactivity(k = 1/1023) annotation(
    Placement(transformation(origin = {-340, 114}, extent = {{10, 10}, {-10, -10}})));
  ThermoPower.customModel.Blocks.SuperTwistingSMC SMC_blower(T_C = 5, alpha = 1e-3, c = 1, lambda = 0.3, phi_lambda = 0.01, w_start = 1) annotation(
    Placement(transformation(origin = {-186, 106}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Blocks.Math.Gain Norm_blower(k = 1/14.3e6) annotation(
    Placement(transformation(origin = {-258, 64}, extent = {{10, 10}, {-10, -10}})));
  Modelica.Blocks.Nonlinear.Limiter limiter_blower(uMax = 1.2, uMin = 0.1) annotation(
    Placement(transformation(origin = {-242, 154}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Blocks.Math.Gain Norm_fwpp(k = 1/823) annotation(
    Placement(transformation(origin = {-164, 74}, extent = {{-10, 10}, {10, -10}})));
  ThermoPower.customModel.Blocks.SuperTwistingSMC SMC_fwpp(T_C = 5, alpha = 4.5e-4, c = 1, lambda = 0.25, phi_lambda = 0.01, w_start = 1) annotation(
    Placement(transformation(origin = {-148, 104}, extent = {{-10, 10}, {10, -10}})));
  Modelica.Blocks.Nonlinear.Limiter limiter_fwpp(uMax = 1.2, uMin = 0.1) annotation(
    Placement(transformation(origin = {-106, 102}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.Gain Norm_cdpp(k = 1/0.85) annotation(
    Placement(transformation(origin = {-28, -50}, extent = {{10, 10}, {-10, -10}})));
  ThermoPower.customModel.Blocks.SuperTwistingSMC SMC_cdpp(T_C = 5, alpha = 6e-4, c = 1, lambda = 0.6, phi_lambda = 0.01, w_start = 1) annotation(
    Placement(transformation(origin = {-38, -88}, extent = {{10, 10}, {-10, -10}})));
  ThermoPower.customModel.Blocks.SuperTwistingSMC SMC_valve(T_C = 5, alpha = 1e-2, c = 1, lambda = 8, phi_lambda = 0.005, w_start = 0.85) annotation(
    Placement(transformation(origin = {-44, 120}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Blocks.Math.Gain Norm_valve(k = 1/60) annotation(
    Placement(transformation(origin = {-8, 102}, extent = {{10, 10}, {-10, -10}})));
  ThermoPower.customModel.Models.Condenser_ACC Condenser(cm = 500, condExchSurface = 4802.84, condNomFlowRate = 54.008, condNomPressure(displayUnit = "kPa") = 2e4, condVol = 26.415, coolExchSurface = 105837, coolNomFlowRate = 7433.86, coolNomPressure = 1e5, coolVol = 4157, gamma_cond = 15e3, gamma_cool = 42, metalVol = 141, pstart_cond(displayUnit = "kPa") = 2e4, rhoMetal(displayUnit = "kg/m3") = 8000) annotation(
    Placement(transformation(origin = {-8, -8}, extent = {{-10, -10}, {10, 10}})));
  ThermoPower.Gas.SourceMassFlow sourceMassFlow(redeclare package Medium = Modelica.Media.Air.SimpleAir, T = 298.15, p0 = 1e5, w0 = 7433.86) annotation(
    Placement(transformation(origin = {28, -22}, extent = {{10, -10}, {-10, 10}})));
  ThermoPower.Gas.SinkPressure sinkPressure(redeclare package Medium = Modelica.Media.Air.SimpleAir, T = 313.15, p0 = 1e5) annotation(
    Placement(transformation(origin = {28, 4}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Ramp ramp31(duration = 1020, height = -0.8357, offset = 1, startTime = 1000) annotation(
    Placement(transformation(origin = {160, 88}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Blocks.Logical.Switch LoadDemand annotation(
    Placement(transformation(origin = {112, 52}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression1(y = time < 5000) annotation(
    Placement(transformation(origin = {160, 52}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Blocks.Sources.CombiTimeTable BaseLoadDemand(extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint, fileName = "/home/wspark/projects/LoadProfile/colocation_10MW_2840nodes_60u_power.txt", startTime = 5000, tableName = "LoadData", tableOnFile = true, timeEvents = Modelica.Blocks.Types.TimeEvents.NoTimeEvents) annotation(
    Placement(transformation(origin = {160, 24}, extent = {{10, -10}, {-10, 10}})));
equation
  connect(economizer_secondary.outfl, evaporator_secondary.infl) annotation(
    Line(points = {{-218, -28}, {-218, -18}}, color = {0, 0, 255}));
  connect(evaporator_secondary.outfl, superheater_secondary.infl) annotation(
    Line(points = {{-218, 2}, {-218, 12}}, color = {0, 0, 255}));
  connect(counterCurrentFV.side1, econonmizer_wall.ext) annotation(
    Line(points = {{-271, -38}, {-247, -38}}, color = {255, 127, 0}));
  connect(economizer_primary.wall, counterCurrentFV.side2) annotation(
    Line(points = {{-311, -38}, {-277, -38}}, color = {255, 127, 0}));
  connect(econonmizer_wall.int, economizer_secondary.wall) annotation(
    Line(points = {{-241, -38}, {-222, -38}}, color = {255, 127, 0}));
  connect(counterCurrentFV1.side1, evaporator_wall.ext) annotation(
    Line(points = {{-271, -8}, {-247, -8}}, color = {255, 127, 0}));
  connect(counterCurrentFV2.side1, superheater_wall.ext) annotation(
    Line(points = {{-271, 22}, {-247, 22}}, color = {255, 127, 0}));
  connect(evaporator_primary.wall, counterCurrentFV1.side2) annotation(
    Line(points = {{-311, -8}, {-277, -8}}, color = {255, 127, 0}));
  connect(evaporator_wall.int, evaporator_secondary.wall) annotation(
    Line(points = {{-241, -8}, {-223, -8}}, color = {255, 127, 0}));
  connect(superheater_primary.wall, counterCurrentFV2.side2) annotation(
    Line(points = {{-311, 22}, {-277, 22}}, color = {255, 127, 0}));
  connect(superheater_wall.int, superheater_secondary.wall) annotation(
    Line(points = {{-241, 22}, {-223, 22}}, color = {255, 127, 0}));
  connect(superheater_primary.outfl, evaporator_primary.infl) annotation(
    Line(points = {{-316, 12}, {-316, 2}}, color = {159, 159, 223}));
  connect(evaporator_primary.outfl, economizer_primary.infl) annotation(
    Line(points = {{-316, -18}, {-316, -28}}, color = {159, 159, 223}));
  connect(Graphite_Avg.int, Channel_Avg.wall) annotation(
    Line(points = {{-403, 0}, {-411, 0}}, color = {255, 127, 0}));
  connect(Fuel_mixture_Avg.int, Graphite_Avg.ext) annotation(
    Line(points = {{-385, 0}, {-398, 0}}, color = {255, 127, 0}));
  connect(Blower.infl, economizer_primary.outfl) annotation(
    Line(points = {{-342, -51.8}, {-342, -47.8}, {-316, -47.8}}, color = {159, 159, 223}));
  connect(coldDuct.infl, Blower.outfl) annotation(
    Line(points = {{-366, -46}, {-366, -47}, {-356, -47}}, color = {159, 159, 223}));
  connect(hotDuct.outfl, superheater_primary.infl) annotation(
    Line(points = {{-366, -26}, {-344, -26}, {-344, 48}, {-316, 48}, {-316, 32}}, color = {159, 159, 223}));
  connect(coldDuct.outfl, lowerPlenum.inlet) annotation(
    Line(points = {{-386, -46}, {-406, -46}, {-406, -38}, {-496, -38}}, color = {159, 159, 223}));
  connect(economizer_secondary.infl, FwPump.outfl) annotation(
    Line(points = {{-218, -48}, {-216, -48}, {-216, -69}, {-184, -69}}, color = {0, 0, 255}));
  connect(generator.port, sens_power.port_a) annotation(
    Line(points = {{-47.4, 36}, {-34.4, 36}}, color = {0, 0, 255}));
  connect(Fuel_mixture_Hot.int, Graphite_Hot.ext) annotation(
    Line(points = {{-471, 0}, {-462, 0}}, color = {255, 127, 0}));
  connect(Graphite_Hot.int, Channel_Hot.wall) annotation(
    Line(points = {{-455, 0}, {-446, 0}}, color = {255, 127, 0}));
  connect(upperPlenum.outlet, Channel_Hot.infl) annotation(
    Line(points = {{-460, 60}, {-442, 60}, {-442, 10}}, color = {159, 159, 223}));
  connect(upperPlenum.outlet, Channel_Avg.infl) annotation(
    Line(points = {{-460, 60}, {-416, 60}, {-416, 10}}, color = {159, 159, 223}));
  connect(Channel_Avg.outfl, hotDuct.infl) annotation(
    Line(points = {{-416, -10}, {-416, -26}, {-386, -26}}, color = {159, 159, 223}));
  connect(Channel_Hot.outfl, hotDuct.infl) annotation(
    Line(points = {{-442, -10}, {-442, -26}, {-386, -26}}, color = {159, 159, 223}));
  connect(superheater_secondary.outfl, valve_turbine.inlet) annotation(
    Line(points = {{-218, 32}, {-218, 43}, {-206, 43}}, color = {0, 0, 255}));
  connect(flowSplit.out1, valve_extraction.inlet) annotation(
    Line(points = {{-135, 20}, {-135, -4}}, color = {0, 0, 255}));
  connect(superheater_primary.infl, sens_T_He.flange) annotation(
    Line(points = {{-316, 32}, {-316, 82}}, color = {159, 159, 223}));
  connect(Fuel_mixture_Avg.Tm_avg, reactorPower_Avg.Tf) annotation(
    Line(points = {{-384, 10.2}, {-390, 10.2}, {-390, 50.2}}, color = {0, 0, 127}));
  connect(Graphite_Avg.Tm_avg, reactorPower_Avg.Tm) annotation(
    Line(points = {{-402, 10.2}, {-402, 28.2}, {-384, 28.2}, {-384, 50.2}}, color = {0, 0, 127}));
  connect(reactorPower_Avg.Power, Fuel_mixture_Avg.heatGenInput) annotation(
    Line(points = {{-375, 58}, {-365, 58}, {-365, 22}, {-381, 22}, {-381, 10}}, color = {0, 0, 127}));
  connect(reactorPower_Avg.Power, Gain_HotChannel.u) annotation(
    Line(points = {{-375, 58}, {-373, 58}, {-373, 90}, {-421, 90}}, color = {0, 0, 127}));
  connect(Gain_HotChannel.y, Fuel_mixture_Hot.heatGenInput) annotation(
    Line(points = {{-443, 90}, {-505, 90}, {-505, 24}, {-477, 24}, {-477, 10}}, color = {0, 0, 127}));
  connect(superheater_secondary.outfl, sens_P_steam.flange) annotation(
    Line(points = {{-218, 32}, {-218, 64}}, color = {0, 0, 255}));
  connect(Gain_blower.y, Blower.in_n) annotation(
    Line(points = {{-293, 98}, {-299, 98}, {-299, 56}, {-351, 56}, {-351, -46}}, color = {0, 0, 127}));
  connect(superheater_secondary.outfl, sens_T_steam.flange) annotation(
    Line(points = {{-218, 32}, {-218, 52}, {-192, 52}, {-192, 64}}, color = {0, 0, 255}));
  connect(Gain_fwpp.y, FwPump.in_n) annotation(
    Line(points = {{-97, 72}, {-87, 72}, {-87, 8}, {-176, 8}, {-176, -68}}, color = {0, 0, 127}));
  connect(valve_extraction.outlet, Deaerator.SteamIn) annotation(
    Line(points = {{-135, -14}, {-132, -14}, {-132, -36}}, color = {0, 0, 255}));
  connect(CdPump.outfl, Deaerator.WaterIn) annotation(
    Line(points = {{-88, -27}, {-90, -27}, {-90, -17}, {-120, -17}, {-120, -37}}, color = {0, 0, 255}));
  connect(Deaerator.CondOut, FwPump.infl) annotation(
    Line(points = {{-126, -54}, {-126, -74}, {-170, -74}}, color = {0, 0, 255}));
  connect(Gain_cdpp.y, CdPump.in_n) annotation(
    Line(points = {{-91, -62}, {-105, -62}, {-105, -12}, {-81, -12}, {-81, -26}}, color = {0, 0, 127}));
  connect(valve_turbine.outlet, HPTB.inlet) annotation(
    Line(points = {{-196, 43}, {-183, 43}, {-183, 44}, {-170, 44}}, color = {0, 0, 255}));
  connect(HPTB.outlet, flowSplit.in1) annotation(
    Line(points = {{-154, 44}, {-154, 26}, {-132, 26}}, color = {0, 0, 255}));
  connect(flowSplit.out2, LPTB.inlet) annotation(
    Line(points = {{-131, 20}, {-125, 20}, {-125, 44}, {-119, 44}}, color = {0, 0, 255}));
  connect(HPTB.shaft_b, LPTB.shaft_a) annotation(
    Line(points = {{-155.6, 36}, {-116.6, 36}}));
  connect(LPTB.shaft_b, generator.shaft) annotation(
    Line(points = {{-103.6, 36}, {-63.6, 36}}));
  connect(grid_v.port, sens_power.port_b) annotation(
    Line(points = {{11.4, 36}, {-13.6, 36}}, color = {0, 0, 255}));
  connect(gain.y, grid_v.pset) annotation(
    Line(points = {{43, 52}, {16, 52}, {16, 44}}, color = {0, 0, 127}));
  connect(grid_v.port, sens_frequency.port) annotation(
    Line(points = {{11.4, 36}, {11.4, 56}}, color = {0, 0, 255}));
  connect(lowerPlenum.outlet, riser.infl) annotation(
    Line(points = {{-516, -38}, {-530, -38}, {-530, -8}}, color = {159, 159, 223}));
  connect(riser.outfl, upperPlenum.inlet) annotation(
    Line(points = {{-530, 12}, {-528, 12}, {-528, 60}, {-480, 60}}, color = {159, 159, 223}));
  connect(Graphite_Hot_Adjacent.int, Fuel_mixture_Hot.ext) annotation(
    Line(points = {{-489, 0}, {-479, 0}}, color = {255, 127, 0}));
  connect(Graphite_Hot_Adjacent.ext, conv_adjacent.side2) annotation(
    Line(points = {{-495.1, 0}, {-507.1, 0}, {-507.1, -26}, {-477.1, -26}, {-477.1, -58}, {-465.1, -58}}, color = {255, 127, 0}));
  connect(tempSource1DFV.wall, conv_adjacent.side1) annotation(
    Line(points = {{-445, -58}, {-459, -58}}, color = {255, 127, 0}));
  connect(AvgTemp_constant.y, tempSource1DFV.temperature) annotation(
    Line(points = {{-425, -58}, {-439, -58}}, color = {0, 0, 127}));
  connect(sens_T_He.T, Norm_reactivity.u) annotation(
    Line(points = {{-323, 92}, {-329, 92}, {-329, 102}, {-319, 102}, {-319, 114}, {-329, 114}}, color = {0, 0, 127}));
  connect(Norm_reactivity.y, SMC_reactivity.u_m) annotation(
    Line(points = {{-351, 114}, {-359, 114}}, color = {0, 0, 127}));
  connect(SMC_reactivity.y, reactorPower_Avg.rho_ext) annotation(
    Line(points = {{-370, 103}, {-370, 77}, {-404, 77}, {-404, 57}, {-392, 57}}, color = {0, 0, 127}));
  connect(SMC_reactivity.y, RhoDerivative.u) annotation(
    Line(points = {{-370, 103}, {-370, 99}, {-394, 99}, {-394, 131}, {-400, 131}}, color = {0, 0, 127}));
  connect(signal_constant.y, SMC_reactivity.u_s) annotation(
    Line(points = {{-282, 161}, {-282, 133}, {-370, 133}, {-370, 125}}, color = {0, 0, 127}));
  connect(sens_P_steam.p, Norm_blower.u) annotation(
    Line(points = {{-226, 74}, {-234, 74}, {-234, 64}, {-246, 64}}, color = {0, 0, 127}));
  connect(Norm_blower.y, SMC_blower.u_m) annotation(
    Line(points = {{-269, 64}, {-281, 64}, {-281, 78}, {-187, 78}, {-187, 94}}, color = {0, 0, 127}));
  connect(SMC_blower.y, limiter_blower.u) annotation(
    Line(points = {{-197, 106}, {-220, 106}, {-220, 154}, {-230, 154}}, color = {0, 0, 127}));
  connect(limiter_blower.y, Gain_blower.u) annotation(
    Line(points = {{-253, 154}, {-261, 154}, {-261, 98}, {-271, 98}}, color = {0, 0, 127}));
  connect(signal_constant.y, SMC_blower.u_s) annotation(
    Line(points = {{-282, 161}, {-282, 133}, {-174, 133}, {-174, 105}}, color = {0, 0, 127}));
  connect(sens_T_steam.T, Norm_fwpp.u) annotation(
    Line(points = {{-184, 74}, {-176, 74}}, color = {0, 0, 127}));
  connect(Norm_fwpp.y, SMC_fwpp.u_s) annotation(
    Line(points = {{-153, 74}, {-139, 74}, {-139, 92}, {-177, 92}, {-177, 104}, {-160, 104}}, color = {0, 0, 127}));
  connect(SMC_fwpp.y, limiter_fwpp.u) annotation(
    Line(points = {{-137, 104}, {-127.5, 104}, {-127.5, 102}, {-118, 102}}, color = {0, 0, 127}));
  connect(limiter_fwpp.y, Gain_fwpp.u) annotation(
    Line(points = {{-95, 102}, {-87, 102}, {-87, 80}, {-131, 80}, {-131, 72}, {-121, 72}}, color = {0, 0, 127}));
  connect(signal_constant.y, SMC_fwpp.u_m) annotation(
    Line(points = {{-282, 161}, {-282, 133}, {-148, 133}, {-148, 116}}, color = {0, 0, 127}));
  connect(Norm_cdpp.y, SMC_cdpp.u_m) annotation(
    Line(points = {{-39, -50}, {-39, -76}}, color = {0, 0, 127}));
  connect(signal_constant.y, SMC_cdpp.u_s) annotation(
    Line(points = {{-282, 161}, {-282, 133}, {84, 133}, {84, -89}, {-26, -89}}, color = {0, 0, 127}));
  connect(SMC_cdpp.y, Gain_cdpp.u) annotation(
    Line(points = {{-49, -88}, {-58, -88}, {-58, -62}, {-68, -62}}, color = {0, 0, 127}));
  connect(sens_frequency.f, Norm_valve.u) annotation(
    Line(points = {{12, 76.2}, {12, 102.2}, {4, 102.2}}, color = {0, 0, 127}));
  connect(Norm_valve.y, SMC_valve.u_m) annotation(
    Line(points = {{-19, 102}, {-47, 102}, {-47, 108}, {-45, 108}}, color = {0, 0, 127}));
  connect(signal_constant.y, SMC_valve.u_s) annotation(
    Line(points = {{-282, 161}, {-282, 133}, {-20, 133}, {-20, 119}, {-32, 119}}, color = {0, 0, 127}));
  connect(SMC_valve.y, valve_turbine.theta) annotation(
    Line(points = {{-55, 120}, {-201, 120}, {-201, 48}}, color = {0, 0, 127}));
  connect(LPTB.outlet, Condenser.steamIn) annotation(
    Line(points = {{-102, 44}, {-74, 44}, {-74, 12}, {-8, 12}, {-8, 2}}, color = {0, 0, 255}));
  connect(sourceMassFlow.flange, Condenser.coolingIn) annotation(
    Line(points = {{18, -22}, {10, -22}, {10, -12}, {2, -12}}, color = {159, 159, 223}));
  connect(Condenser.coolingOut, sinkPressure.flange) annotation(
    Line(points = {{2, -2}, {10, -2}, {10, 4}, {18, 4}}, color = {159, 159, 223}));
  connect(Condenser.waterOut, CdPump.infl) annotation(
    Line(points = {{-8, -18}, {-8, -32}, {-74, -32}}, color = {0, 0, 255}));
  connect(Condenser.ratio_VvonVtot, Norm_cdpp.u) annotation(
    Line(points = {{-18, -6}, {-28, -6}, {-28, -28}, {-4, -28}, {-4, -50}, {-16, -50}}, color = {0, 0, 127}));
  connect(ramp31.y, LoadDemand.u1) annotation(
    Line(points = {{149, 88}, {136, 88}, {136, 60}, {124, 60}}, color = {0, 0, 127}));
  connect(booleanExpression1.y, LoadDemand.u2) annotation(
    Line(points = {{149, 52}, {124, 52}}, color = {255, 0, 255}));
  connect(BaseLoadDemand.y[1], LoadDemand.u3) annotation(
    Line(points = {{149, 24}, {135, 24}, {135, 44}, {123, 44}}, color = {0, 0, 127}));
  connect(LoadDemand.y, gain.u) annotation(
    Line(points = {{102, 52}, {66, 52}}, color = {0, 0, 127}));
  annotation(
    experiment(StartTime = 0, StopTime = 10000, Tolerance = 1e-06, Interval = 10),
    Diagram(coordinateSystem(extent = {{-500, 140}, {100, -60}})),
    Documentation(info = "<HTML>
<p> All controllers are replaced with SMC. Other than this, same with BaseLoad_PID model<p>
</html>"));
end BaseLoad_SMC;