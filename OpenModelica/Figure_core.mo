within ReferenceOM.TransientRuns;

model Figure_core "Reference basic-profile test model for tuning PID. Compatible with v0.25"
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
  // -------------------------------------------------------------------------
  // Nested PID control-system wrapper for diagram simplification
  // -------------------------------------------------------------------------

  model ControlSystem_PID "PID control system connected through sensor and actuator buses"
    ThermoPower.customModel.Interfaces.SensorBus sensorBus annotation(
      Placement(transformation(origin = {-90, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}})));
    ThermoPower.customModel.Interfaces.ActuatorBus actuatorBus annotation(
      Placement(transformation(origin = {90, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Sources.Constant signal_constant(k = 1) annotation(
      Placement(transformation(origin = {-70, 82}, extent = {{-8, -8}, {8, 8}})));
    ThermoPower.customModel.Blocks.LimPID_Tinit PID_reactivity(Ti = 50, controllerType = Modelica.Blocks.Types.SimpleController.PI, initType = Modelica.Blocks.Types.InitPID.InitialState, k = 0.5, u_m_nom = 1023, useInitTime = false, xi_start = 0/0.003, yMax = 50e-3, yMin = -50e-3, y_start = 0) annotation(
      Placement(transformation(origin = {-20, 60}, extent = {{-10, -10}, {10, 10}})));
    ThermoPower.customModel.Blocks.LimPID_Tinit PID_blower(Ti = 35, controllerType = Modelica.Blocks.Types.SimpleController.PI, initType = Modelica.Blocks.Types.InitPID.InitialState, k = 1.5, u_m_nom = 14.3e6, useInitTime = false, xi_start = 1/1.5, yMax = 1.2, yMin = 0.1, y_start = 1) annotation(
      Placement(transformation(origin = {-20, 30}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Math.Gain Gain_blower(k = 1800) annotation(
      Placement(transformation(origin = {25, 30}, extent = {{-8, -8}, {8, 8}})));
    ThermoPower.customModel.Blocks.LimPID_Tinit PID_fwpp(Ti = 35, controllerType = Modelica.Blocks.Types.SimpleController.PI, initType = Modelica.Blocks.Types.InitPID.InitialState, k = 1.5, u_s_nom = 823, useInitTime = false, xi_start = 1/1.5, yMax = 1.2, yMin = 0.1, y_start = 1) annotation(
      Placement(transformation(origin = {-20, 0}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Math.Gain Gain_fwpp(k = 1800) annotation(
      Placement(transformation(origin = {25, 0}, extent = {{-8, -8}, {8, 8}})));
    ThermoPower.customModel.Blocks.LimPID_Tinit PID_cdpp(Ti = 50, controllerType = Modelica.Blocks.Types.SimpleController.PI, initType = Modelica.Blocks.Types.InitPID.InitialState, k = 3.4, u_m_nom = 0.85, useInitTime = false, xi_start = 1/3.4, yMax = 1.2, yMin = 0.1, y_start = 1) annotation(
      Placement(transformation(origin = {-20, -30}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Math.Gain Gain_cdpp(k = 1800) annotation(
      Placement(transformation(origin = {25, -30}, extent = {{-8, -8}, {8, 8}})));
    ThermoPower.customModel.Blocks.LimPID_Tinit PID_valve(Ti = 30, controllerType = Modelica.Blocks.Types.SimpleController.PI, initType = Modelica.Blocks.Types.InitPID.InitialState, k = 75, u_m_nom = 60, useInitTime = false, xi_start = 0.85/75, yMax = 1, yMin = 0.05, y_start = 1) annotation(
      Placement(transformation(origin = {-20, -60}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Continuous.Derivative RhoDerivative(T = 0.1, initType = Modelica.Blocks.Types.Init.InitialState) annotation(
      Placement(transformation(origin = {-354, 172}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  equation
// Sensor bus -> controller measurements
    connect(sensorBus.T_He, PID_reactivity.u_m) annotation(
      Line(points = {{-90, 0}, {-78, 0}, {-78, 52}, {-20, 52}}, color = {0, 0, 127}, thickness = 1.5));
    connect(sensorBus.P_steam, PID_blower.u_m) annotation(
      Line(points = {{-90, 0}, {-74, 0}, {-74, 22}, {-20, 22}}, color = {0, 0, 127}, thickness = 1.5));
    connect(sensorBus.T_steam, PID_fwpp.u_s) annotation(
      Line(points = {{-90, 0}, {-62, 0}, {-32, 0}}, color = {0, 0, 127}, thickness = 1.5));
    connect(sensorBus.condenserLevel, PID_cdpp.u_m) annotation(
      Line(points = {{-90, 0}, {-74, 0}, {-74, -38}, {-20, -38}}, color = {0, 0, 127}, thickness = 1.5));
    connect(sensorBus.frequency, PID_valve.u_m) annotation(
      Line(points = {{-90, 0}, {-78, 0}, {-78, -68}, {-20, -68}}, color = {0, 0, 127}, thickness = 1.5));
// Normalized set points
    connect(signal_constant.y, PID_reactivity.u_s) annotation(
      Line(points = {{-61, 82}, {-46, 82}, {-46, 60}, {-32, 60}}, color = {0, 0, 127}));
    connect(signal_constant.y, PID_blower.u_s) annotation(
      Line(points = {{-61, 82}, {-50, 82}, {-50, 30}, {-32, 30}}, color = {0, 0, 127}));
// FWPP uses the reversed u_s/u_m connection of the original model.
    connect(signal_constant.y, PID_fwpp.u_m) annotation(
      Line(points = {{-61, 82}, {-54, 82}, {-54, -8}, {-20, -8}}, color = {0, 0, 127}));
    connect(signal_constant.y, PID_cdpp.u_s) annotation(
      Line(points = {{-61, 82}, {-58, 82}, {-58, -30}, {-32, -30}}, color = {0, 0, 127}));
    connect(signal_constant.y, PID_valve.u_s) annotation(
      Line(points = {{-61, 82}, {-62, 82}, {-62, -60}, {-32, -60}}, color = {0, 0, 127}));
// Controller outputs -> actuator bus
    connect(PID_blower.y, Gain_blower.u) annotation(
      Line(points = {{-8, 30}, {15, 30}}, color = {0, 0, 127}));
    connect(Gain_blower.y, actuatorBus.blower_n) annotation(
      Line(points = {{34, 30}, {66, 30}, {66, 0}, {90, 0}}, color = {0, 0, 127}));
    connect(PID_fwpp.y, Gain_fwpp.u) annotation(
      Line(points = {{-9, 0}, {15, 0}}, color = {0, 0, 127}));
    connect(Gain_fwpp.y, actuatorBus.fwpp_n) annotation(
      Line(points = {{34, 0}, {90, 0}}, color = {0, 0, 127}));
    connect(PID_cdpp.y, Gain_cdpp.u) annotation(
      Line(points = {{-8, -30}, {15, -30}}, color = {0, 0, 127}));
    connect(Gain_cdpp.y, actuatorBus.cdpp_n) annotation(
      Line(points = {{34, -30}, {66, -30}, {66, 0}, {90, 0}}, color = {0, 0, 127}));
    connect(PID_valve.y, actuatorBus.turbineValveTheta) annotation(
      Line(points = {{-8, -60}, {70, -60}, {70, 0}, {90, 0}}, color = {0, 0, 127}));
    connect(PID_reactivity.y, actuatorBus.rho_ext) annotation(
      Line(points = {{-8, -60}, {70, -60}, {70, 0}, {90, 0}}, color = {0, 127, 0}));
    connect(PID_reactivity.y, RhoDerivative.u) annotation(
      Line(points = {{-8, -60}, {70, -60}, {70, 0}, {90, 0}}, color = {0, 0, 127}));
    annotation(
      Diagram(coordinateSystem(extent = {{-100, 100}, {100, -100}})),
      Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(lineColor = {0, 0, 127}, fillColor = {235, 235, 235}, fillPattern = FillPattern.Solid, extent = {{-100, 70}, {100, -70}}), Text(textColor = {0, 0, 127}, extent = {{-86, 30}, {86, -30}}, textString = "Controllers")}));
  end ControlSystem_PID;

  model DataCenterLoadIcon
    Modelica.Blocks.Interfaces.RealOutput P_load "Data center load signal" annotation(
      Placement(transformation(extent = {{100, -10}, {120, 10}}), iconTransformation(extent = {{100, -10}, {120, 10}})));
    annotation(
      Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-100, -100}, {100, 100}}, lineColor = {0, 0, 127}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-70, 25}, {-20, -65}}, lineColor = {0, 0, 127}, fillColor = {230, 230, 230}, fillPattern = FillPattern.Solid), Rectangle(extent = {{20, 25}, {70, -65}}, lineColor = {0, 0, 127}, fillColor = {230, 230, 230}, fillPattern = FillPattern.Solid), Line(points = {{-65, 5}, {-25, 5}}, color = {0, 0, 127}), Line(points = {{-65, -20}, {-25, -20}}, color = {0, 0, 127}), Line(points = {{-65, -45}, {-25, -45}}, color = {0, 0, 127}), Line(points = {{25, 5}, {65, 5}}, color = {0, 0, 127}), Line(points = {{25, -20}, {65, -20}}, color = {0, 0, 127}), Line(points = {{25, -45}, {65, -45}}, color = {0, 0, 127})}));
  end DataCenterLoadIcon;
  ThermoPower.Gas.Flow1DFV hotDuct(A = 0.78, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Kfnom, L = 5, redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He, N = 5, Nt = 1, Tstartbar = 1023.15, dpnom(displayUnit = "Pa") = 3000, e = 0.00015, omega = 1*3.14, pstart(displayUnit = "MPa") = 6e6, wnom = 81.6, wnf = 0.5, wnm = 0.1, Dhyd = 1, Kfnom = 2, DynamicMomentum = true) annotation(
    Placement(transformation(origin = {-219, -169}, extent = {{-19, -19}, {19, 19}})));
  ThermoPower.Gas.Flow1DFV Channel_Avg(A = 2e-4, Dhyd = 1.6e-2, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Colebrook, L = 8, redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He, N = 21, Nt = 3274, Tstartbar = 823.15, dpnom = 1e5, e = 0.00015, omega = 1.6e-2*3.14, pstart(displayUnit = "MPa") = 6e6, wnom = 81.6*3274/3275, wnf = 0.5, wnm = 0.1, Tstartin = 598.15, Tstartout = 1023.15, redeclare model HeatTransfer = ThermoPower.Thermal.HeatTransferFV.DittusBoelter(Re_min = 700), noInitialPressure = true, DynamicMomentum = true) annotation(
    Placement(transformation(origin = {-249, -33}, extent = {{-19, -19}, {19, 19}}, rotation = -90)));
  ThermoPower.customModel.Models.RadialConduction1D ll1llasdf(L = 8, Nr = 5, Nt = 3274, Nw = 20, Tstartbar = 1023.15, lambda = 23.24, rext = 38e-3/2, rhomcm = 2341.42*1800, rint = 25.3e-3/2, useExternalHeatGen = true, useHeatGen = true, axialProfile = {0.04278298, 0.05092866, 0.05695018, 0.06107518, 0.06352006, 0.06449002, 0.06417902, 0.06276982, 0.06043394, 0.0573317, 0.05361218, 0.04941327, 0.04486162, 0.04007265, 0.03515058, 0.03018841, 0.02526791, 0.02045963, 0.01582291, 0.01140586}) annotation(
    Placement(transformation(origin = {-155, -33}, extent = {{-23, 23}, {23, -23}}, rotation = -90)));
  ThermoPower.customModel.Models.RadialConduction1D l1l1l(L = 8, Nr = 5, Nt = 3274, Nw = 20, Tstartbar = 1023.15, lambda = 23.6, rext = 25.3e-3/2, rhomcm = 1780*1979.2, rint = 16e-3/2, useExternalHeatGen = false, useHeatGen = false) annotation(
    Placement(transformation(origin = {-201, -33}, extent = {{-23, 23}, {23, -23}}, rotation = -90)));
  ThermoPower.Gas.Header upperPlenum(redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He, Tmstart = 598.15, Tstart = 598.15, V = 53.88, pstart(displayUnit = "MPa") = 6e6) annotation(
    Placement(transformation(origin = {-296, 150}, extent = {{-22, -22}, {22, 22}}, rotation = -90)));
  ThermoPower.Gas.Flow1DFV Channel_Hot(A = 2e-4, Dhyd = 1.6e-2, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Colebrook, redeclare model HeatTransfer = ThermoPower.Thermal.HeatTransferFV.DittusBoelter(Re_min = 700), L = 8, redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He, N = 21, Nt = 1, Tstartbar = 823.15, Tstartin = 598.15, Tstartout = 1023.15, dpnom = 1e5, e = 0.00015, omega = 1.6e-2*3.14, pstart(displayUnit = "MPa") = 6e6, wnf = 0.5, wnm = 0.1, wnom = 81.6*1/3275, DynamicMomentum = true) annotation(
    Placement(transformation(origin = {-343, -33}, extent = {{19, -19}, {-19, 19}}, rotation = 90)));
  ThermoPower.customModel.Models.RadialConduction1D l(L = 8, Nr = 5, Nt = 1, Nw = 20, Tstartbar = 1023.15, axialProfile = {0.04278298, 0.05092866, 0.05695018, 0.06107518, 0.06352006, 0.06449002, 0.06417902, 0.06276982, 0.06043394, 0.0573317, 0.05361218, 0.04941327, 0.04486162, 0.04007265, 0.03515058, 0.03018841, 0.02526791, 0.02045963, 0.01582291, 0.01140586}, lambda = 23.24, rext = 38e-3/2, rhomcm = 2341.42*1800, rint = 25.3e-3/2, useExternalHeatGen = true, useHeatGen = true) annotation(
    Placement(transformation(origin = {-427, -33}, extent = {{23, 23}, {-23, -23}}, rotation = 90)));
  ThermoPower.customModel.Models.RadialConduction1D ll(L = 8, Nr = 5, Nt = 1, Nw = 20, Tstartbar = 1023.15, lambda = 23.6, rext = 25.3e-3/2, rhomcm = 1780*1979.2, rint = 16e-3/2, useExternalHeatGen = false, useHeatGen = false) annotation(
    Placement(transformation(origin = {-383, -33}, extent = {{23, 23}, {-23, -23}}, rotation = 90)));
  ThermoPower.customModel.Models.ReactorPower reactorPower_Avg(P0 = 180e6/(3274 + 1.59)*3274, Tf0 = 943, Tm0 = 926, alpha_f = -4.2e-5, alpha_m = -8.55e-5, usePKE = true, useRhoExt = true, useTc = false, useTf = true, useTm = true, useXe = true) annotation(
    Placement(transformation(origin = {-85, 79}, extent = {{23, -23}, {-23, 23}})));
  ThermoPower.customModel.Models.RadialConduction1D llll(L = 8, Nr = 5, Nt = 6, Nw = 20, Tstartbar = 1023.15, lambda = 23.6, rext = 38e-3/2*2, rhomcm = 1780*1979.2, rint = 38e-3/2, useExternalHeatGen = false, useHeatGen = false) annotation(
    Placement(transformation(origin = {-467, -33}, extent = {{23, 23}, {-23, -23}}, rotation = 90)));
  ThermoPower.Thermal.ConvHTFV lll(Nv = 20, G = 430*(2*3.14*16e-3/2*8)*6) annotation(
    Placement(transformation(origin = {-508, -32}, extent = {{24, -24}, {-24, 24}}, rotation = 90)));
  ThermoPower.Thermal.TempSource1DFV lllll(Nw = 20) annotation(
    Placement(transformation(origin = {-546, -32}, extent = {{24, -24}, {-24, 24}}, rotation = 90)));
  Modelica.Blocks.Sources.Constant ll1 annotation(
    Placement(transformation(origin = {-586, -32}, extent = {{-12, -12}, {12, 12}}, rotation = -0)));
  // Sensor/actuator buses and nested controller wrapper
  ThermoPower.customModel.Interfaces.ActuatorBus Actuators annotation(
    Placement(transformation(origin = {-3, 157}, extent = {{-21, -21}, {21, 21}}), iconTransformation(origin = {0, 160}, extent = {{-10, -10}, {10, 10}})));
equation
// -------------------------------------------------------------------------
// Sensor signals -> SensorBus
// -------------------------------------------------------------------------
// SensorBus -> control wrapper
// Control wrapper -> ActuatorBus
// -------------------------------------------------------------------------
// ActuatorBus -> plant actuators
// -------------------------------------------------------------------------
  connect(l1l1l.int, Channel_Avg.wall) annotation(
    Line(points = {{-208, -33}, {-239.5, -33}}, color = {255, 127, 0}, thickness = 1.5));
  connect(Channel_Hot.wall, ll.int) annotation(
    Line(points = {{-352.5, -33}, {-376, -33}}, color = {255, 127, 0}, thickness = 1.5));
  connect(ll.ext, l.int) annotation(
    Line(points = {{-390, -33}, {-420, -33}}, color = {255, 127, 0}, thickness = 1.5));
  connect(l1l1l.ext, ll1llasdf.int) annotation(
    Line(points = {{-194, -33}, {-162, -33}}, color = {255, 127, 0}, thickness = 1.5));
  connect(llll.int, l.ext) annotation(
    Line(points = {{-460, -33}, {-434, -33}}, color = {255, 127, 0}));
  connect(lll.side2, llll.ext) annotation(
    Line(points = {{-501, -32}, {-497, -32}, {-497, -33}, {-474, -33}}, color = {255, 127, 0}));
  connect(lllll.wall, lll.side1) annotation(
    Line(points = {{-539, -32}, {-515, -32}}, color = {255, 127, 0}));
  connect(ll1.y, lllll.temperature) annotation(
    Line(points = {{-573, -32}, {-556, -32}}, color = {0, 0, 127}));
  connect(Channel_Hot.outfl, hotDuct.infl) annotation(
    Line(points = {{-342, -52}, {-344, -52}, {-344, -102}, {-294, -102}, {-294, -168}, {-238, -168}}, color = {159, 159, 223}));
  connect(Channel_Avg.outfl, hotDuct.infl) annotation(
    Line(points = {{-249, -52}, {-250, -52}, {-250, -102}, {-294, -102}, {-294, -168}, {-238, -168}}, color = {159, 159, 223}));
  connect(Channel_Hot.infl, upperPlenum.outlet) annotation(
    Line(points = {{-342, -14}, {-342, 32}, {-296, 32}, {-296, 128}}, color = {159, 159, 223}));
  connect(Channel_Avg.infl, upperPlenum.outlet) annotation(
    Line(points = {{-249, -14}, {-250, -14}, {-250, 32}, {-296, 32}, {-296, 128}}, color = {159, 159, 223}));
  connect(ll1llasdf.Tm_avg, reactorPower_Avg.Tf) annotation(
    Line(points = {{-160, -10}, {-160, 14}, {-72, 14}, {-72, 58}}, color = {0, 85, 0}, pattern = LinePattern.Dash, thickness = 0.75));
  connect(l1l1l.Tm_avg, reactorPower_Avg.Tm) annotation(
    Line(points = {{-206, -10}, {-206, 14}, {-84, 14}, {-84, 58}}, color = {0, 85, 0}, pattern = LinePattern.Dash, thickness = 0.75));
  connect(reactorPower_Avg.Power, ll1llasdf.heatGenInput) annotation(
    Line(points = {{-106, 80}, {-150, 80}, {-150, -10}}, color = {255, 0, 0}, pattern = LinePattern.Dash, thickness = 0.75));
  connect(reactorPower_Avg.Power, l.heatGenInput) annotation(
    Line(points = {{-106, 80}, {-432, 80}, {-432, -10}}, color = {255, 0, 0}, pattern = LinePattern.Dash, thickness = 0.75));
  connect(reactorPower_Avg.rho_ext, Actuators) annotation(
    Line(points = {{-64, 80}, {-42, 80}, {-42, 158}, {-2, 158}}, color = {170, 0, 255}, thickness = 1.5));
  annotation(
    experiment(StartTime = 0, StopTime = 10000, Tolerance = 1e-06, Interval = 5),
    Diagram(coordinateSystem(extent = {{-740, -220}, {420, 220}})),
    Documentation(info = "<HTML>

<b>Ramp Profile</b><p>

<Li>Equilibrium up to 5000s

<Li>Maintain steady-state for 100 s

<Li>Ramp down to 15% at a rate of 5%/min

<Li>Maintain 15% for 20 min

<Li>Ramp up to 100% at a rate of 5%/min

<Li>Maintain 100% for the rest

</ul>

</html>"),
    Icon(coordinateSystem(extent = {{-740, -220}, {420, 220}})));
end Figure_core;