within ReferenceOM.Characterization;

  model freq_amp_SMC "Reference model for SMC-version freq_amp analysis. Compatible with v0.25"
  ThermoPower.Water.Flow1DFV2ph economizer_secondary(A = 0.0001337, Dhyd = 13.05e-3, DynamicMomentum = true, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Colebrook, FluidPhaseStart = ThermoPower.Choices.FluidPhase.FluidPhases.Liquid, redeclare model HeatTransfer = ThermoPower.Thermal.HeatTransferFV.DittusBoelter, Kfc = 2, L = 12.9, N = 10, Nt = 359, dpnom(displayUnit = "kPa") = 176000, e = 0.00015, hstartin = 856795, hstartout = 1559329, noInitialPressure = false, omega = 0.041, pstart(displayUnit = "MPa") = 1.45e7, wnf = 0.5, wnm = 0.1, wnom = 69.08) annotation(
      Placement(transformation(origin = {-32, -72}, extent = {{10, 10}, {-10, -10}}, rotation = -90)));
  ThermoPower.Water.Flow1DFV2ph evaporator_secondary(A = 0.0001337, Dhyd = 13.05e-3, DynamicMomentum = true, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Colebrook, FluidPhaseStart = ThermoPower.Choices.FluidPhase.FluidPhases.TwoPhases, redeclare model HeatTransfer = ThermoPower.Thermal.HeatTransferFV.DittusBoelter, Kfc = 2, L = 10.2, N = 10, Nt = 359, dpnom(displayUnit = "kPa") = 143000, e = 0.00015, hstartin = 1575931, hstartout = 2611643, noInitialPressure = false, omega = 0.041, pstart(displayUnit = "MPa") = 1.44e7, wnf = 0.5, wnm = 0.1, wnom = 69.08) annotation(
      Placement(transformation(origin = {-32, -42}, extent = {{10, 10}, {-10, -10}}, rotation = -90)));
  ThermoPower.Water.Flow1DFV2ph superheater_secondary(A = 0.0001337, Dhyd = 13.05e-3, DynamicMomentum = true, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Colebrook, FluidPhaseStart = ThermoPower.Choices.FluidPhase.FluidPhases.Steam, redeclare model HeatTransfer = ThermoPower.Thermal.HeatTransferFV.DittusBoelter, Kfc = 2, L = 6.9, N = 10, Nt = 359, dpnom(displayUnit = "kPa") = 9e4, e = 0.00015, hstartin = 2660669, hstartout = 3430465, noInitialPressure = false, omega = 0.041, pstart(displayUnit = "MPa") = 1.43e7, wnf = 0.5, wnm = 0.1, wnom = 69.08) annotation(
      Placement(transformation(origin = {-32, -12}, extent = {{10, 10}, {-10, -10}}, rotation = -90)));
  ThermoPower.Gas.Flow1DFV economizer_primary(A = 3.06, Dhyd = 19.05e-3, DynamicMomentum = true, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Kfnom, redeclare model HeatTransfer = ThermoPower.customModel.Models.ZukauskasInLineHTC(pt_OD = 1.5), Kfnom = 27, L = 12.9, redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He, N = 10, Nt = 1, Tstartbar = 650.15, dpnom = 1e5, e = 0.00015, omega = 21.457, pstart(displayUnit = "MPa") = 6e6, wnf = 0.1, wnm = 0.1, wnom = 81.6) annotation(
      Placement(transformation(origin = {-130, -72}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  ThermoPower.Gas.Flow1DFV evaporator_primary(A = 3.06, Dhyd = 19.05e-3, DynamicMomentum = true, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Kfnom, redeclare model HeatTransfer = ThermoPower.customModel.Models.ZukauskasInLineHTC(pt_OD = 1.5), Kfnom = 27, L = 10.2, redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He, N = 10, Nt = 1, Tstartbar = 770.15, dpnom = 1e5, e = 0.00015, omega = 21.457, pstart(displayUnit = "MPa") = 6e6, wnf = 0.1, wnm = 0.1, wnom = 81.6) annotation(
      Placement(transformation(origin = {-130, -42}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  ThermoPower.Gas.Flow1DFV superheater_primary(A = 3.06, Dhyd = 19.05e-3, DynamicMomentum = true, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Kfnom, redeclare model HeatTransfer = ThermoPower.customModel.Models.ZukauskasInLineHTC(pt_OD = 1.5), Kfnom = 27, L = 6.9, redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He, N = 10, Nt = 1, Tstartbar = 1023.15, dpnom = 1e5, e = 0.00015, omega = 21.457, pstart(displayUnit = "MPa") = 6e6, wnf = 0.1, wnm = 0.1, wnom = 81.6) annotation(
      Placement(transformation(origin = {-130, -12}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  ThermoPower.Thermal.MetalTubeFV econonmizer_wall(L = 12.9, Nt = 359, Nw = 9, Tstartbar = 623.15, lambda = 22, rext = 19.05e-3/2, rhomcm = 4000000, rint = 13.05e-3/2) annotation(
      Placement(transformation(origin = {-58, -72}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  ThermoPower.Thermal.CounterCurrentFV counterCurrentFV(Nw = 9) annotation(
      Placement(transformation(origin = {-88, -72}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  ThermoPower.Thermal.MetalTubeFV evaporator_wall(L = 10.2, Nt = 359, Nw = 9, Tstartbar = 723.15, lambda = 22, rext = 19.05e-3/2, rhomcm = 4000000, rint = 13.05e-3/2) annotation(
      Placement(transformation(origin = {-58, -42}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  ThermoPower.Thermal.CounterCurrentFV counterCurrentFV1(Nw = 9) annotation(
      Placement(transformation(origin = {-88, -42}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  ThermoPower.Thermal.MetalTubeFV superheater_wall(L = 6.9, Nt = 359, Nw = 9, Tstartbar = 873.15, lambda = 22, rext = 19.05e-3/2, rhomcm = 4000000, rint = 13.05e-3/2) annotation(
      Placement(transformation(origin = {-58, -12}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  ThermoPower.Thermal.CounterCurrentFV counterCurrentFV2(Nw = 9) annotation(
      Placement(transformation(origin = {-88, -12}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  inner ThermoPower.System system(allowFlowReversal = false, fnom = 60, initOpt = ThermoPower.Choices.Init.Options.fixedState) annotation(
      Placement(transformation(origin = {14, 132}, extent = {{-10, -10}, {10, 10}})));
  ThermoPower.Electrical.Generator generator(Np = 1, Pnom(displayUnit = "MW") = 6.55e7, fstart = 60, referenceGenerator = true) annotation(
      Placement(transformation(origin = {130, 2}, extent = {{-10, -10}, {10, 10}})));
  ThermoPower.Water.FlowSplit flowSplit annotation(
      Placement(transformation(origin = {53, -11}, extent = {{-5, 5}, {5, -5}}, rotation = -90)));
  ThermoPower.Water.Pump CdPump(dp0(displayUnit = "MPa") = 1.41e6, redeclare function efficiencyCharacteristic = ThermoPower.Functions.PumpCharacteristics.constantEfficiency(eta_nom = 0.85), redeclare function flowCharacteristic = ThermoPower.Functions.PumpCharacteristics.quadraticFlow(head_nom = {300.72743947238007, 146.23388533741434, 105.87333298428797}, q_nom = {0, 0.054870609296703905, 0.07133179208571508}), hstart = 193516, n0 = 1800, rho0(displayUnit = "kg/m3") = 983.13, use_in_n = true, w0 = 54.008) annotation(
      Placement(transformation(origin = {104, -68}, extent = {{10, -10}, {-10, 10}})));
  ThermoPower.Water.Pump FwPump(dp0(displayUnit = "MPa") = 1.3312e7, redeclare function efficiencyCharacteristic = ThermoPower.Functions.PumpCharacteristics.constantEfficiency(eta_nom = 0.85), redeclare function flowCharacteristic = ThermoPower.Functions.PumpCharacteristics.quadraticFlow(head_nom = {3085.5366742612923, 1561.0976244723518, 1130.2346801179826}, q_nom = {0, 0.07947880436649801, 0.10332244567644742}), hstart = 856795, n0 = 1800, rho0(displayUnit = "kg/m3") = 869.24, use_in_n = true, w0 = 69.08) annotation(
      Placement(transformation(origin = {8, -110}, extent = {{10, -10}, {-10, 10}})));
  ThermoPower.Gas.Flow1DFV hotDuct(A = 0.78, Dhyd = 1, DynamicMomentum = true, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Kfnom, Kfnom = 2, L = 5, redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He, N = 5, Nt = 1, Tstartbar = 1023.15, dpnom(displayUnit = "Pa") = 3000, e = 0.00015, omega = 1*3.14, pstart(displayUnit = "MPa") = 6e6, wnf = 0.5, wnm = 0.1, wnom = 81.6) annotation(
      Placement(transformation(origin = {-190, -60}, extent = {{-10, -10}, {10, 10}})));
  ThermoPower.Gas.Flow1DFV Channel_Avg(A = 2e-4, Dhyd = 1.6e-2, DynamicMomentum = true, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Colebrook, redeclare model HeatTransfer = ThermoPower.Thermal.HeatTransferFV.DittusBoelter(Re_min = 700), L = 8, redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He, N = 21, Nt = 3274, Tstartbar = 823.15, Tstartin = 598.15, Tstartout = 1023.15, dpnom = 1e5, e = 0.00015, noInitialPressure = true, omega = 1.6e-2*3.14, pstart(displayUnit = "MPa") = 6e6, wnf = 0.5, wnm = 0.1, wnom = 81.6*3274/3275) annotation(
      Placement(transformation(origin = {-230, -34}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  ThermoPower.customModel.Models.RadialConduction1D Fuel_mixture_Avg(L = 8, Nr = 5, Nt = 3274, Nw = 20, Tstartbar = 1023.15, axialProfile = {0.04278298, 0.05092866, 0.05695018, 0.06107518, 0.06352006, 0.06449002, 0.06417902, 0.06276982, 0.06043394, 0.0573317, 0.05361218, 0.04941327, 0.04486162, 0.04007265, 0.03515058, 0.03018841, 0.02526791, 0.02045963, 0.01582291, 0.01140586}, lambda = 23.24, rext = 38e-3/2, rhomcm = 2341.42*1800, rint = 25.3e-3/2, useExternalHeatGen = true, useHeatGen = true) annotation(
      Placement(transformation(origin = {-196, -34}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
  ThermoPower.Gas.Flow1DFV coldDuct(A = 0.78, Dhyd = 0.41, DynamicMomentum = true, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Kfnom, Kfnom = 2, L = 5, redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He, N = 5, Nt = 1, Tstartbar = 598.15, dpnom(displayUnit = "Pa") = 3000, e = 0.00015, noInitialPressure = true, omega = 0.41*3.14, pstart(displayUnit = "MPa") = 6e6, wnf = 0.5, wnm = 0.1, wnom = 81.6) annotation(
      Placement(transformation(origin = {-190, -80}, extent = {{10, -10}, {-10, 10}})));
  ThermoPower.customModel.Models.Fan Blower(redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He, dp0(displayUnit = "Pa") = 1.8e5, redeclare function efficiencyCharacteristic = ThermoPower.Functions.PumpCharacteristics.constantEfficiency(eta_nom = 0.85), redeclare function flowCharacteristic = ThermoPower.Functions.FanCharacteristics.quadraticFlow(H_nom = {64854.44254405128, 37753.17324575091, 27333.29742992366}, q_nom = {0, 17.11477187140708, 22.249203432829205}), n0 = 1800, rho0(displayUnit = "kg/m3") = 4.77, use_in_n = true, w0 = 81.6) annotation(
      Placement(transformation(origin = {-164, -88}, extent = {{10, -10}, {-10, 10}})));
  ThermoPower.customModel.Models.RadialConduction1D Graphite_Avg(L = 8, Nr = 5, Nt = 3274, Nw = 20, Tstartbar = 1023.15, lambda = 23.6, rext = 25.3e-3/2, rhomcm = 1780*1979.2, rint = 16e-3/2, useExternalHeatGen = false, useHeatGen = false) annotation(
      Placement(transformation(origin = {-214, -34}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
  ThermoPower.Gas.Header lowerPlenum(redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He, Tmstart = 598.15, Tstart = 598.15, V = 62.59, pstart(displayUnit = "MPa") = 6e6) annotation(
      Placement(transformation(origin = {-320, -72}, extent = {{10, -10}, {-10, 10}})));
  ThermoPower.Gas.Header upperPlenum(redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He, Tmstart = 598.15, Tstart = 598.15, V = 53.88, pstart(displayUnit = "MPa") = 6e6) annotation(
      Placement(transformation(origin = {-284, 26}, extent = {{-10, -10}, {10, 10}})));
  ThermoPower.Electrical.PowerSensor sens_power annotation(
      Placement(transformation(origin = {162, 2}, extent = {{-10, 10}, {10, -10}})));
  ThermoPower.Gas.Flow1DFV Channel_Hot(A = 2e-4, Dhyd = 1.6e-2, DynamicMomentum = true, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Colebrook, redeclare model HeatTransfer = ThermoPower.Thermal.HeatTransferFV.DittusBoelter(Re_min = 700), L = 8, redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He, N = 21, Nt = 1, Tstartbar = 823.15, Tstartin = 598.15, Tstartout = 1023.15, dpnom = 1e5, e = 0.00015, omega = 1.6e-2*3.14, pstart(displayUnit = "MPa") = 6e6, wnf = 0.5, wnm = 0.1, wnom = 81.6*1/3275) annotation(
      Placement(transformation(origin = {-256, -34}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
  ThermoPower.customModel.Models.RadialConduction1D Fuel_mixture_Hot(L = 8, Nr = 5, Nt = 1, Nw = 20, Tstartbar = 1023.15, axialProfile = {0.04278298, 0.05092866, 0.05695018, 0.06107518, 0.06352006, 0.06449002, 0.06417902, 0.06276982, 0.06043394, 0.0573317, 0.05361218, 0.04941327, 0.04486162, 0.04007265, 0.03515058, 0.03018841, 0.02526791, 0.02045963, 0.01582291, 0.01140586}, lambda = 23.24, rext = 38e-3/2, rhomcm = 2341.42*1800, rint = 25.3e-3/2, useExternalHeatGen = true, useHeatGen = true) annotation(
      Placement(transformation(origin = {-288, -34}, extent = {{10, 10}, {-10, -10}}, rotation = 90)));
  ThermoPower.customModel.Models.RadialConduction1D Graphite_Hot(L = 8, Nr = 5, Nt = 1, Nw = 20, Tstartbar = 1023.15, lambda = 23.6, rext = 25.3e-3/2, rhomcm = 1780*1979.2, rint = 16e-3/2, useExternalHeatGen = false, useHeatGen = false) annotation(
      Placement(transformation(origin = {-272, -34}, extent = {{10, 10}, {-10, -10}}, rotation = 90)));
  ThermoPower.Water.ValveVap valve_turbine(CvData = ThermoPower.Choices.Valve.CvTypes.OpPoint, redeclare function FlowChar = ThermoPower.Functions.ValveCharacteristics.quadratic, dpnom(displayUnit = "Pa") = 5e5, pnom(displayUnit = "Pa") = 1.43e7, rhonom(displayUnit = "kg/m3") = 41.35, theta_fix = 0.85, thetanom = 0.85, useThetaInput = true, wnom = 69.08) annotation(
      Placement(transformation(origin = {-15, 9}, extent = {{-5, -5}, {5, 5}})));
  ThermoPower.Water.ValveVap valve_extraction(CvData = ThermoPower.Choices.Valve.CvTypes.OpPoint, redeclare function FlowChar = ThermoPower.Functions.ValveCharacteristics.quadratic, dpnom(displayUnit = "Pa") = 143000, pnom(displayUnit = "Pa") = 1.573e6, rhonom(displayUnit = "kg/m3") = 6.719, theta_fix = 0.5, thetanom = 0.5, useThetaInput = false, wnom = 15.079) annotation(
      Placement(transformation(origin = {51, -43}, extent = {{-5, 5}, {5, -5}}, rotation = -90)));
  ThermoPower.customModel.Models.ReactorPower reactorPower_Avg(P0 = 180e6/(3274 + 1.59)*3274, Tf0 = 943, Tm0 = 926, alpha_f = -4.2e-5, alpha_m = -8.55e-5, usePKE = true, useRhoExt = true, useTc = false, useTf = true, useTm = true, useXe = true) annotation(
      Placement(transformation(origin = {-198, 24}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Constant signal_constant(k = 1) annotation(
      Placement(transformation(origin = {-96, 138}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  ThermoPower.Gas.SensT1 sens_T_He(redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He) annotation(
      Placement(transformation(origin = {-130, 52}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Blocks.Math.Gain Gain_HotChannel(k = 1.59/3274) annotation(
      Placement(transformation(origin = {-246, 56}, extent = {{10, 10}, {-10, -10}})));
  ThermoPower.Water.SensP sens_P_steam annotation(
      Placement(transformation(origin = {-32, 34}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Blocks.Math.Gain Gain_blower(k = 1800) annotation(
      Placement(transformation(origin = {-96, 64}, extent = {{10, 10}, {-10, -10}})));
  ThermoPower.Water.SensT1 sens_T_steam annotation(
      Placement(transformation(origin = {-6, 34}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.Gain Gain_fwpp(k = 1800) annotation(
      Placement(transformation(origin = {78, 38}, extent = {{10, -10}, {-10, 10}}, rotation = -180)));
  ThermoPower.customModel.Models.Deaerator Deaerator(V = 25, pstart(displayUnit = "MPa") = 1.43e6) annotation(
      Placement(transformation(origin = {60, -78}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
  Modelica.Blocks.Math.Gain Gain_cdpp(k = 1800) annotation(
      Placement(transformation(origin = {106, -96}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  ThermoPower.customModel.Models.SteamTurbineStodolaEta HPTB(Kt = 0.00296, PRstart = 8.773, eta_iso_nom = 0.85, pnom(displayUnit = "MPa") = 1.38e7, useMflowCorrection = true, useWetnessCorrection = true, wnom = 69.08) annotation(
      Placement(transformation(origin = {24, 2}, extent = {{-10, -10}, {10, 10}})));
  ThermoPower.customModel.Models.SteamTurbineStodolaEta LPTB(Kt = 0.01661, PRstart = 78.65, eta_iso_nom = 0.85, pnom(displayUnit = "MPa") = 1.573e6, useMflowCorrection = true, useWetnessCorrection = true, wnom = 54.008) annotation(
      Placement(transformation(origin = {76, 2}, extent = {{-10, -10}, {10, 10}})));
  ThermoPower.customModel.Models.Grid_v grid_v(Pgrid(displayUnit = "W") = 65.5e6, pset_const = 65.5e6, use_in_pset = true) annotation(
      Placement(transformation(origin = {206, 2}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.Gain gain(k = 65.5e6) annotation(
      Placement(transformation(origin = {240, 18}, extent = {{10, -10}, {-10, 10}})));
  ThermoPower.Electrical.FrequencySensor sens_frequency annotation(
      Placement(transformation(origin = {198, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  ThermoPower.Gas.Flow1DFV riser(A = 3.74, Dhyd = 0.54, DynamicMomentum = true, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Kfnom, Kfnom = 2, L = 8, redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He, N = 5, Nt = 1, Tstartbar = 598.15, dpnom(displayUnit = "Pa") = 3000, e = 0.00015, noInitialPressure = true, omega = 0.54*3.14, pstart(displayUnit = "MPa") = 6e6, wnf = 0.5, wnm = 0.1, wnom = 81.6) annotation(
      Placement(transformation(origin = {-344, -32}, extent = {{10, 10}, {-10, -10}}, rotation = -90)));
  Modelica.Blocks.Continuous.Derivative RhoDerivative(T = 0.1, initType = Modelica.Blocks.Types.Init.InitialState) annotation(
      Placement(transformation(origin = {-226, 98}, extent = {{10, -10}, {-10, 10}})));
  ThermoPower.customModel.Models.RadialConduction1D Graphite_Hot_Adjacent(L = 8, Nr = 5, Nt = 6, Nw = 20, Tstartbar = 1023.15, lambda = 23.6, rext = 38e-3/2*2, rhomcm = 1780*1979.2, rint = 38e-3/2, useExternalHeatGen = false, useHeatGen = false) annotation(
      Placement(transformation(origin = {-306, -34}, extent = {{10, 10}, {-10, -10}}, rotation = 90)));
  ThermoPower.Thermal.ConvHTFV conv_adjacent(G = 430*(2*3.14*16e-3/2*8)*6, Nv = 20) annotation(
      Placement(transformation(origin = {-276, -92}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  ThermoPower.Thermal.TempSource1DFV tempSource1DFV(Nw = 20) annotation(
      Placement(transformation(origin = {-256, -92}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Sources.Constant AvgTemp_constant(k = 1023) annotation(
      Placement(transformation(origin = {-228, -92}, extent = {{10, -10}, {-10, 10}})));
  ThermoPower.customModel.Blocks.SuperTwistingSMC SMC_reactivity(T_C = 5, alpha = 5e-5, c = 1, lambda = 0.1, phi_lambda = 0.01, w_start = 0) annotation(
      Placement(transformation(origin = {-184, 80}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
  Modelica.Blocks.Math.Gain Norm_reactivity(k = 1/1023) annotation(
      Placement(transformation(origin = {-154, 80}, extent = {{10, 10}, {-10, -10}})));
  ThermoPower.customModel.Blocks.SuperTwistingSMC SMC_blower(T_C = 5, alpha = 1e-3, c = 1, lambda = 0.3, phi_lambda = 0.01, w_start = 1) annotation(
      Placement(transformation(origin = {0, 72}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Blocks.Math.Gain Norm_blower(k = 1/14.3e6) annotation(
      Placement(transformation(origin = {-72, 30}, extent = {{10, 10}, {-10, -10}})));
  Modelica.Blocks.Nonlinear.Limiter limiter_blower(uMax = 1.2, uMin = 0.1) annotation(
      Placement(transformation(origin = {-56, 120}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Blocks.Math.Gain Norm_fwpp(k = 1/823) annotation(
      Placement(transformation(origin = {22, 40}, extent = {{-10, 10}, {10, -10}})));
  ThermoPower.customModel.Blocks.SuperTwistingSMC SMC_fwpp(T_C = 5, alpha = 4.5e-4, c = 1, lambda = 0.25, phi_lambda = 0.01, w_start = 1) annotation(
      Placement(transformation(origin = {32, 68}, extent = {{-10, 10}, {10, -10}})));
  Modelica.Blocks.Nonlinear.Limiter limiter_fwpp(uMax = 1.2, uMin = 0.1) annotation(
      Placement(transformation(origin = {80, 68}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.Gain Norm_cdpp(k = 1/0.85) annotation(
      Placement(transformation(origin = {158, -84}, extent = {{10, 10}, {-10, -10}})));
  ThermoPower.customModel.Blocks.SuperTwistingSMC SMC_cdpp(T_C = 5, alpha = 6e-4, c = 1, lambda = 0.6, phi_lambda = 0.01, w_start = 1) annotation(
      Placement(transformation(origin = {148, -122}, extent = {{10, 10}, {-10, -10}})));
  ThermoPower.customModel.Blocks.SuperTwistingSMC SMC_valve(T_C = 5, alpha = 1e-2, c = 1, lambda = 8, phi_lambda = 0.005, w_start = 0.85) annotation(
      Placement(transformation(origin = {142, 86}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Blocks.Math.Gain Norm_valve(k = 1/60) annotation(
      Placement(transformation(origin = {178, 68}, extent = {{10, 10}, {-10, -10}})));
  Modelica.Blocks.Sources.Sine LoadDemand(amplitude = 0.2, freqHz = 0.00333, offset = 0.5, startTime = 3000) annotation(
      Placement(transformation(origin = {334, -8}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Blocks.Sources.Ramp ramp3(duration = 600, height = -0.5, offset = 1, startTime = 500) annotation(
      Placement(transformation(origin = {334, 54}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Blocks.Logical.Switch LoadDemand1 annotation(
      Placement(transformation(origin = {286, 18}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y = time < 3000) annotation(
      Placement(transformation(origin = {334, 18}, extent = {{10, -10}, {-10, 10}})));
  ThermoPower.customModel.Models.Condenser_ACC Condenser(cm = 500, condExchSurface = 4802.84, condNomFlowRate = 54.008, condNomPressure(displayUnit = "kPa") = 2e4, condVol = 26.415, coolExchSurface = 105837, coolNomFlowRate = 7433.86, coolNomPressure = 1e5, coolVol = 4157, gamma_cond = 15e3, gamma_cool = 42, metalVol = 141, pstart_cond(displayUnit = "kPa") = 2e4, rhoMetal(displayUnit = "kg/m3") = 8000) annotation(
    Placement(transformation(origin = {196, -48}, extent = {{-10, -10}, {10, 10}})));
  ThermoPower.Gas.SourceMassFlow sourceMassFlow(redeclare package Medium = Modelica.Media.Air.SimpleAir, T = 298.15, p0 = 1e5, w0 = 7433.86) annotation(
    Placement(transformation(origin = {232, -62}, extent = {{10, -10}, {-10, 10}})));
  ThermoPower.Gas.SinkPressure sinkPressure(redeclare package Medium = Modelica.Media.Air.SimpleAir, T = 313.15, p0 = 1e5) annotation(
    Placement(transformation(origin = {232, -36}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(economizer_secondary.outfl, evaporator_secondary.infl) annotation(
    Line(points = {{-32, -62}, {-32, -52}}, color = {0, 0, 255}));
  connect(evaporator_secondary.outfl, superheater_secondary.infl) annotation(
    Line(points = {{-32, -32}, {-32, -22}}, color = {0, 0, 255}));
  connect(counterCurrentFV.side1, econonmizer_wall.ext) annotation(
    Line(points = {{-85, -72}, {-61, -72}}, color = {255, 127, 0}));
  connect(economizer_primary.wall, counterCurrentFV.side2) annotation(
    Line(points = {{-125, -72}, {-91, -72}}, color = {255, 127, 0}));
  connect(econonmizer_wall.int, economizer_secondary.wall) annotation(
    Line(points = {{-55, -72}, {-36, -72}}, color = {255, 127, 0}));
  connect(counterCurrentFV1.side1, evaporator_wall.ext) annotation(
    Line(points = {{-85, -42}, {-61, -42}}, color = {255, 127, 0}));
  connect(counterCurrentFV2.side1, superheater_wall.ext) annotation(
    Line(points = {{-85, -12}, {-61, -12}}, color = {255, 127, 0}));
  connect(evaporator_primary.wall, counterCurrentFV1.side2) annotation(
    Line(points = {{-125, -42}, {-91, -42}}, color = {255, 127, 0}));
  connect(evaporator_wall.int, evaporator_secondary.wall) annotation(
    Line(points = {{-55, -42}, {-37, -42}}, color = {255, 127, 0}));
  connect(superheater_primary.wall, counterCurrentFV2.side2) annotation(
    Line(points = {{-125, -12}, {-91, -12}}, color = {255, 127, 0}));
  connect(superheater_wall.int, superheater_secondary.wall) annotation(
    Line(points = {{-55, -12}, {-37, -12}}, color = {255, 127, 0}));
  connect(superheater_primary.outfl, evaporator_primary.infl) annotation(
    Line(points = {{-130, -22}, {-130, -32}}, color = {159, 159, 223}));
  connect(evaporator_primary.outfl, economizer_primary.infl) annotation(
    Line(points = {{-130, -52}, {-130, -62}}, color = {159, 159, 223}));
  connect(Graphite_Avg.int, Channel_Avg.wall) annotation(
    Line(points = {{-217, -34}, {-225, -34}}, color = {255, 127, 0}));
  connect(Fuel_mixture_Avg.int, Graphite_Avg.ext) annotation(
    Line(points = {{-199, -34}, {-212, -34}}, color = {255, 127, 0}));
  connect(Blower.infl, economizer_primary.outfl) annotation(
    Line(points = {{-156, -85.8}, {-156, -81.8}, {-130, -81.8}}, color = {159, 159, 223}));
  connect(coldDuct.infl, Blower.outfl) annotation(
    Line(points = {{-180, -80}, {-180, -81}, {-170, -81}}, color = {159, 159, 223}));
  connect(hotDuct.outfl, superheater_primary.infl) annotation(
    Line(points = {{-180, -60}, {-158, -60}, {-158, 14}, {-130, 14}, {-130, -2}}, color = {159, 159, 223}));
  connect(coldDuct.outfl, lowerPlenum.inlet) annotation(
    Line(points = {{-200, -80}, {-220, -80}, {-220, -72}, {-310, -72}}, color = {159, 159, 223}));
  connect(economizer_secondary.infl, FwPump.outfl) annotation(
    Line(points = {{-32, -82}, {-30, -82}, {-30, -103}, {2, -103}}, color = {0, 0, 255}));
  connect(generator.port, sens_power.port_a) annotation(
    Line(points = {{138.6, 2}, {151.6, 2}}, color = {0, 0, 255}));
  connect(Fuel_mixture_Hot.int, Graphite_Hot.ext) annotation(
    Line(points = {{-285, -34}, {-276, -34}}, color = {255, 127, 0}));
  connect(Graphite_Hot.int, Channel_Hot.wall) annotation(
    Line(points = {{-269, -34}, {-260, -34}}, color = {255, 127, 0}));
  connect(upperPlenum.outlet, Channel_Hot.infl) annotation(
    Line(points = {{-274, 26}, {-256, 26}, {-256, -24}}, color = {159, 159, 223}));
  connect(upperPlenum.outlet, Channel_Avg.infl) annotation(
    Line(points = {{-274, 26}, {-230, 26}, {-230, -24}}, color = {159, 159, 223}));
  connect(Channel_Avg.outfl, hotDuct.infl) annotation(
    Line(points = {{-230, -44}, {-230, -60}, {-200, -60}}, color = {159, 159, 223}));
  connect(Channel_Hot.outfl, hotDuct.infl) annotation(
    Line(points = {{-256, -44}, {-256, -60}, {-200, -60}}, color = {159, 159, 223}));
  connect(superheater_secondary.outfl, valve_turbine.inlet) annotation(
    Line(points = {{-32, -2}, {-32, 9}, {-20, 9}}, color = {0, 0, 255}));
  connect(flowSplit.out1, valve_extraction.inlet) annotation(
    Line(points = {{51, -14}, {51, -38}}, color = {0, 0, 255}));
  connect(superheater_primary.infl, sens_T_He.flange) annotation(
    Line(points = {{-130, -2}, {-130, 48}}, color = {159, 159, 223}));
  connect(Fuel_mixture_Avg.Tm_avg, reactorPower_Avg.Tf) annotation(
    Line(points = {{-198, -23.8}, {-204, -23.8}, {-204, 16.2}}, color = {0, 0, 127}));
  connect(Graphite_Avg.Tm_avg, reactorPower_Avg.Tm) annotation(
    Line(points = {{-216, -23.8}, {-216, -5.8}, {-198, -5.8}, {-198, 16.2}}, color = {0, 0, 127}));
  connect(reactorPower_Avg.Power, Fuel_mixture_Avg.heatGenInput) annotation(
    Line(points = {{-189, 24}, {-179, 24}, {-179, -12}, {-195, -12}, {-195, -24}}, color = {0, 0, 127}));
  connect(reactorPower_Avg.Power, Gain_HotChannel.u) annotation(
    Line(points = {{-189, 24}, {-187, 24}, {-187, 56}, {-235, 56}}, color = {0, 0, 127}));
  connect(Gain_HotChannel.y, Fuel_mixture_Hot.heatGenInput) annotation(
    Line(points = {{-257, 56}, {-319, 56}, {-319, -10}, {-291, -10}, {-291, -24}}, color = {0, 0, 127}));
  connect(superheater_secondary.outfl, sens_P_steam.flange) annotation(
    Line(points = {{-32, -2}, {-32, 30}}, color = {0, 0, 255}));
  connect(Gain_blower.y, Blower.in_n) annotation(
    Line(points = {{-107, 64}, {-113, 64}, {-113, 22}, {-165, 22}, {-165, -80}}, color = {0, 0, 127}));
  connect(superheater_secondary.outfl, sens_T_steam.flange) annotation(
    Line(points = {{-32, -2}, {-32, 18}, {-6, 18}, {-6, 30}}, color = {0, 0, 255}));
  connect(Gain_fwpp.y, FwPump.in_n) annotation(
    Line(points = {{89, 38}, {99, 38}, {99, -26}, {10, -26}, {10, -102}}, color = {0, 0, 127}));
  connect(valve_extraction.outlet, Deaerator.SteamIn) annotation(
    Line(points = {{51, -48}, {54, -48}, {54, -70}}, color = {0, 0, 255}));
  connect(CdPump.outfl, Deaerator.WaterIn) annotation(
    Line(points = {{98, -61}, {96, -61}, {96, -51}, {66, -51}, {66, -71}}, color = {0, 0, 255}));
  connect(Deaerator.CondOut, FwPump.infl) annotation(
    Line(points = {{60, -88}, {60, -108}, {16, -108}}, color = {0, 0, 255}));
  connect(Gain_cdpp.y, CdPump.in_n) annotation(
    Line(points = {{95, -96}, {81, -96}, {81, -46}, {105, -46}, {105, -60}}, color = {0, 0, 127}));
  connect(valve_turbine.outlet, HPTB.inlet) annotation(
    Line(points = {{-10, 9}, {3, 9}, {3, 10}, {16, 10}}, color = {0, 0, 255}));
  connect(HPTB.outlet, flowSplit.in1) annotation(
    Line(points = {{32, 10}, {32, -8}, {54, -8}}, color = {0, 0, 255}));
  connect(flowSplit.out2, LPTB.inlet) annotation(
    Line(points = {{55, -14}, {61, -14}, {61, 10}, {67, 10}}, color = {0, 0, 255}));
  connect(HPTB.shaft_b, LPTB.shaft_a) annotation(
    Line(points = {{30.4, 2}, {69.4, 2}}));
  connect(LPTB.shaft_b, generator.shaft) annotation(
    Line(points = {{82.4, 2}, {122.4, 2}}));
  connect(grid_v.port, sens_power.port_b) annotation(
    Line(points = {{197.4, 2}, {172.4, 2}}, color = {0, 0, 255}));
  connect(gain.y, grid_v.pset) annotation(
    Line(points = {{229, 18}, {202, 18}, {202, 10}}, color = {0, 0, 127}));
  connect(grid_v.port, sens_frequency.port) annotation(
    Line(points = {{197.4, 2}, {197.4, 22}}, color = {0, 0, 255}));
  connect(lowerPlenum.outlet, riser.infl) annotation(
    Line(points = {{-330, -72}, {-344, -72}, {-344, -42}}, color = {159, 159, 223}));
  connect(riser.outfl, upperPlenum.inlet) annotation(
    Line(points = {{-344, -22}, {-342, -22}, {-342, 26}, {-294, 26}}, color = {159, 159, 223}));
  connect(Graphite_Hot_Adjacent.int, Fuel_mixture_Hot.ext) annotation(
    Line(points = {{-303, -34}, {-293, -34}}, color = {255, 127, 0}));
  connect(Graphite_Hot_Adjacent.ext, conv_adjacent.side2) annotation(
    Line(points = {{-309.1, -34}, {-321.1, -34}, {-321.1, -60}, {-291.1, -60}, {-291.1, -92}, {-279.1, -92}}, color = {255, 127, 0}));
  connect(tempSource1DFV.wall, conv_adjacent.side1) annotation(
    Line(points = {{-259, -92}, {-273, -92}}, color = {255, 127, 0}));
  connect(AvgTemp_constant.y, tempSource1DFV.temperature) annotation(
    Line(points = {{-239, -92}, {-253, -92}}, color = {0, 0, 127}));
  connect(sens_T_He.T, Norm_reactivity.u) annotation(
    Line(points = {{-137, 58}, {-143, 58}, {-143, 68}, {-133, 68}, {-133, 80}, {-143, 80}}, color = {0, 0, 127}));
  connect(Norm_reactivity.y, SMC_reactivity.u_m) annotation(
    Line(points = {{-165, 80}, {-173, 80}}, color = {0, 0, 127}));
  connect(SMC_reactivity.y, reactorPower_Avg.rho_ext) annotation(
    Line(points = {{-184, 69}, {-184, 43}, {-218, 43}, {-218, 23}, {-206, 23}}, color = {0, 0, 127}));
  connect(SMC_reactivity.y, RhoDerivative.u) annotation(
    Line(points = {{-184, 69}, {-184, 65}, {-208, 65}, {-208, 97}, {-214, 97}}, color = {0, 0, 127}));
  connect(signal_constant.y, SMC_reactivity.u_s) annotation(
    Line(points = {{-96, 127}, {-96, 99}, {-184, 99}, {-184, 91}}, color = {0, 0, 127}));
  connect(sens_P_steam.p, Norm_blower.u) annotation(
    Line(points = {{-40, 40}, {-48, 40}, {-48, 30}, {-60, 30}}, color = {0, 0, 127}));
  connect(Norm_blower.y, SMC_blower.u_m) annotation(
    Line(points = {{-83, 30}, {-95, 30}, {-95, 44}, {-1, 44}, {-1, 60}}, color = {0, 0, 127}));
  connect(SMC_blower.y, limiter_blower.u) annotation(
    Line(points = {{-11, 72}, {-34, 72}, {-34, 120}, {-44, 120}}, color = {0, 0, 127}));
  connect(limiter_blower.y, Gain_blower.u) annotation(
    Line(points = {{-67, 120}, {-75, 120}, {-75, 64}, {-85, 64}}, color = {0, 0, 127}));
  connect(signal_constant.y, SMC_blower.u_s) annotation(
    Line(points = {{-96, 127}, {-96, 99}, {12, 99}, {12, 71}}, color = {0, 0, 127}));
  connect(sens_T_steam.T, Norm_fwpp.u) annotation(
    Line(points = {{2, 40}, {10, 40}}, color = {0, 0, 127}));
  connect(Norm_fwpp.y, SMC_fwpp.u_s) annotation(
    Line(points = {{33, 40}, {47, 40}, {47, 58}, {9, 58}, {9, 68}, {19, 68}}, color = {0, 0, 127}));
  connect(SMC_fwpp.y, limiter_fwpp.u) annotation(
    Line(points = {{43, 68}, {68, 68}}, color = {0, 0, 127}));
  connect(limiter_fwpp.y, Gain_fwpp.u) annotation(
    Line(points = {{91, 68}, {99, 68}, {99, 46}, {55, 46}, {55, 38}, {65, 38}}, color = {0, 0, 127}));
  connect(signal_constant.y, SMC_fwpp.u_m) annotation(
    Line(points = {{-96, 127}, {-96, 99}, {32, 99}, {32, 79}}, color = {0, 0, 127}));
  connect(Norm_cdpp.y, SMC_cdpp.u_m) annotation(
    Line(points = {{147, -84}, {147, -110}}, color = {0, 0, 127}));
  connect(signal_constant.y, SMC_cdpp.u_s) annotation(
    Line(points = {{-96, 127}, {-96, 99}, {270, 99}, {270, -123}, {160, -123}}, color = {0, 0, 127}));
  connect(SMC_cdpp.y, Gain_cdpp.u) annotation(
    Line(points = {{137, -122}, {128, -122}, {128, -96}, {118, -96}}, color = {0, 0, 127}));
  connect(sens_frequency.f, Norm_valve.u) annotation(
    Line(points = {{198, 42.2}, {198, 68.2}, {190, 68.2}}, color = {0, 0, 127}));
  connect(Norm_valve.y, SMC_valve.u_m) annotation(
    Line(points = {{167, 68}, {139, 68}, {139, 74}, {141, 74}}, color = {0, 0, 127}));
  connect(signal_constant.y, SMC_valve.u_s) annotation(
    Line(points = {{-96, 127}, {-96, 99}, {166, 99}, {166, 85}, {154, 85}}, color = {0, 0, 127}));
  connect(SMC_valve.y, valve_turbine.theta) annotation(
    Line(points = {{131, 86}, {-15, 86}, {-15, 14}}, color = {0, 0, 127}));
  connect(ramp3.y, LoadDemand1.u1) annotation(
    Line(points = {{323, 54}, {310, 54}, {310, 26}, {298, 26}}, color = {0, 0, 127}));
  connect(booleanExpression.y, LoadDemand1.u2) annotation(
    Line(points = {{323, 18}, {298, 18}}, color = {255, 0, 255}));
  connect(LoadDemand.y, LoadDemand1.u3) annotation(
    Line(points = {{323, -8}, {307, -8}, {307, 10}, {297, 10}}, color = {0, 0, 127}));
  connect(LoadDemand1.y, gain.u) annotation(
    Line(points = {{276, 18}, {252, 18}}, color = {0, 0, 127}));
  connect(LPTB.outlet, Condenser.steamIn) annotation(
    Line(points = {{84, 10}, {114, 10}, {114, -26}, {196, -26}, {196, -38}}, color = {0, 0, 255}));
  connect(Condenser.ratio_VvonVtot, Norm_cdpp.u) annotation(
    Line(points = {{186, -46}, {180, -46}, {180, -84}, {170, -84}}, color = {0, 0, 127}));
  connect(Condenser.waterOut, CdPump.infl) annotation(
    Line(points = {{196, -58}, {196, -66}, {112, -66}}, color = {0, 0, 255}));
  connect(sourceMassFlow.flange, Condenser.coolingIn) annotation(
    Line(points = {{222, -62}, {214, -62}, {214, -52}, {206, -52}}, color = {159, 159, 223}));
  connect(Condenser.coolingOut, sinkPressure.flange) annotation(
    Line(points = {{206, -42}, {214, -42}, {214, -36}, {222, -36}}, color = {159, 159, 223}));
  annotation(
      experiment(StartTime = 0, StopTime = 7500, Tolerance = 1e-06, Interval = 30),
      Documentation(info = "<HTML>
  <p><b>SMC version of frequency-amplitude analysis.</b><p>
  <p>Reach and maintain 50% of power until 3000s, after which sine wave is given.<p.
  </ul>
  </html>"));
end freq_amp_SMC;