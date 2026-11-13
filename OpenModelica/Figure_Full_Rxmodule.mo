model Figure_Full_Rxmodule "Reference basic-profile test model for tuning PID. Compatible with v0.25"
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


model ReactorCore
  "Simplified reactor-core wrapper"

  replaceable package Medium =
      Modelica.Media.IdealGases.SingleGases.He
    constrainedby Modelica.Media.Interfaces.PartialMedium;


  // ============================================================
  // External connectors
  // ============================================================

  // Helium inlet - TOP
  ThermoPower.Gas.FlangeA inlet(
    redeclare package Medium = Medium)
    annotation(
      Placement(
        transformation(extent={{-10,90},{10,110}}),
        iconTransformation(extent={{-10,90},{10,110}})
      ));


  // Helium outlet - BOTTOM
  ThermoPower.Gas.FlangeB outlet(
    redeclare package Medium = Medium)
    annotation(
      Placement(
        transformation(extent={{-10,-110},{10,-90}}),
        iconTransformation(extent={{-10,-110},{10,-90}})
      ));


  // Actuator signal - RIGHT
  Modelica.Blocks.Interfaces.RealInput actuatorSignal
    "Actuator signal to reactor core"
    annotation(
      Placement(
        transformation(extent={{120,-20},{80,20}}),
        iconTransformation(origin = {36, -7}, extent = {{66, -11}, {44, 11}})));


  // ============================================================
  // Core coolant channel
  // ============================================================

  ThermoPower.Gas.Flow1DFV coreFlow(
    redeclare package Medium = Medium,

    A = 2e-4,
    Dhyd = 1.6e-2,
    FFtype = ThermoPower.Choices.Flow1D.FFtypes.Colebrook,

    L = 8,
    N = 21,
    Nt = 3274,

    Tstartbar = 823.15,
    Tstartin = 598.15,
    Tstartout = 1023.15,

    pstart = 6e6,
    dpnom = 1e5,

    wnom = 81.6*3274/3275,

    e = 0.00015,
    omega = 1.6e-2*3.14,

    wnf = 0.5,
    wnm = 0.1,

    noInitialPressure = true,
    DynamicMomentum = true,

    redeclare model HeatTransfer =
      ThermoPower.Thermal.HeatTransferFV.DittusBoelter(
        Re_min = 700))

    annotation(
      Placement(
        transformation(
          origin={0,0},
          extent={{-20,-20},{20,20}},
          rotation=-90)
      ));


equation

  // Top inlet -> core
  connect(inlet, coreFlow.infl)
    annotation(
      Line(
        points={{0,100},{0,20}},
        color={159,159,223}));


  // Core -> bottom outlet
  connect(coreFlow.outfl, outlet)
    annotation(
      Line(
        points={{0,-20},{0,-100}},
        color={159,159,223}));


annotation(

  Icon(
    coordinateSystem(
      preserveAspectRatio=true,
      extent={{-100,-100},{100,100}}),

    graphics={

      // Outer box
      Rectangle(
        extent={{-80,-80},{80,80}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),

      // Title
      Text(
        extent={{-70,72},{70,47}},
        textString="REACTOR CORE",
        lineColor={0,0,127}),

      // Simplified fuel/core channels
      Rectangle(
        extent={{-50,30},{-25,-45}},
        lineColor={0,0,127},
        fillColor={230,230,230},
        fillPattern=FillPattern.Solid),

      Rectangle(
        extent={{-12,30},{12,-45}},
        lineColor={0,0,127},
        fillColor={230,230,230},
        fillPattern=FillPattern.Solid),

      Rectangle(
        extent={{25,30},{50,-45}},
        lineColor={0,0,127},
        fillColor={230,230,230},
        fillPattern=FillPattern.Solid),

      // A few simple divisions
      Line(
        points={{-50,5},{-25,5}},
        color={0,0,127}),
      Line(
        points={{-50,-20},{-25,-20}},
        color={0,0,127}),

      Line(
        points={{-12,5},{12,5}},
        color={0,0,127}),
      Line(
        points={{-12,-20},{12,-20}},
        color={0,0,127}),

      Line(
        points={{25,5},{50,5}},
        color={0,0,127}),
      Line(
        points={{25,-20},{50,-20}},
        color={0,0,127})

    }
  )
);

end ReactorCore;



  ThermoPower.Water.Flow1DFV2ph economizer_secondary(A = 0.0001337, Dhyd = 13.05e-3, DynamicMomentum = true, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Colebrook, FluidPhaseStart = ThermoPower.Choices.FluidPhase.FluidPhases.Liquid, redeclare model HeatTransfer = ThermoPower.Thermal.HeatTransferFV.DittusBoelter, L = 12.9, N = 10, Nt = 359, dpnom(displayUnit = "kPa") = 176000, e = 0.00015, hstartin = 856795, hstartout = 1559329, noInitialPressure = false, omega = 0.041, pstart(displayUnit = "MPa") = 1.45e7, wnf = 0.5, wnm = 0.1, wnom = 69.08, Kfc = 2) annotation(
    Placement(transformation(origin = {-144, -132}, extent = {{18, 18}, {-18, -18}}, rotation = -90)));
  ThermoPower.Water.Flow1DFV2ph evaporator_secondary(A = 0.0001337, Dhyd = 13.05e-3, DynamicMomentum = true, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Colebrook, FluidPhaseStart = ThermoPower.Choices.FluidPhase.FluidPhases.TwoPhases, redeclare model HeatTransfer = ThermoPower.Thermal.HeatTransferFV.DittusBoelter, L = 10.2, N = 10, Nt = 359, dpnom(displayUnit = "kPa") = 143000, e = 0.00015, hstartin = 1575931, hstartout = 2611643, noInitialPressure = false, omega = 0.041, pstart(displayUnit = "MPa") = 1.44e7, wnf = 0.5, wnm = 0.1, wnom = 69.08, Kfc = 2) annotation(
    Placement(transformation(origin = {-144, -80}, extent = {{18, 18}, {-18, -18}}, rotation = -90)));
  ThermoPower.Water.Flow1DFV2ph superheater_secondary(A = 0.0001337, Dhyd = 13.05e-3, DynamicMomentum = true, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Colebrook, FluidPhaseStart = ThermoPower.Choices.FluidPhase.FluidPhases.Steam, redeclare model HeatTransfer = ThermoPower.Thermal.HeatTransferFV.DittusBoelter, L = 6.9, N = 10, Nt = 359, dpnom(displayUnit = "kPa") = 9e4, e = 0.00015, hstartin = 2660669, hstartout = 3430465, noInitialPressure = false, omega = 0.041, pstart(displayUnit = "MPa") = 1.43e7, wnf = 0.5, wnm = 0.1, wnom = 69.08, Kfc = 2) annotation(
    Placement(transformation(origin = {-144, -26}, extent = {{18, 18}, {-18, -18}}, rotation = -90)));
  ThermoPower.Gas.Flow1DFV economizer_primary(A = 3.06, Dhyd = 19.05e-3, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Kfnom, redeclare model HeatTransfer = ThermoPower.customModel.Models.ZukauskasInLineHTC(pt_OD = 1.5), Kfnom = 27, L = 12.9, redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He, N = 10, Nt = 1, Tstartbar = 650.15, dpnom = 1e5, e = 0.00015, omega = 21.457, pstart(displayUnit = "MPa") = 6e6, wnom = 81.6, wnf = 0.1, wnm = 0.1, DynamicMomentum = true) annotation(
    Placement(transformation(origin = {-263, -133}, extent = {{-19, -19}, {19, 19}}, rotation = -90)));
  ThermoPower.Gas.Flow1DFV evaporator_primary(A = 3.06, Dhyd = 19.05e-3, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Kfnom, redeclare model HeatTransfer = ThermoPower.customModel.Models.ZukauskasInLineHTC(pt_OD = 1.5), Kfnom = 27, L = 10.2, redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He, N = 10, Nt = 1, Tstartbar = 770.15, dpnom = 1e5, e = 0.00015, omega = 21.457, pstart(displayUnit = "MPa") = 6e6, wnom = 81.6, wnf = 0.1, wnm = 0.1, DynamicMomentum = true) annotation(
    Placement(transformation(origin = {-263, -81}, extent = {{-19, -19}, {19, 19}}, rotation = -90)));
  ThermoPower.Gas.Flow1DFV superheater_primary(A = 3.06, Dhyd = 19.05e-3, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Kfnom, redeclare model HeatTransfer = ThermoPower.customModel.Models.ZukauskasInLineHTC(pt_OD = 1.5), Kfnom = 27, L = 6.9, redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He, N = 10, Nt = 1, Tstartbar = 1023.15, dpnom = 1e5, e = 0.00015, omega = 21.457, pstart(displayUnit = "MPa") = 6e6, wnom = 81.6, wnf = 0.1, wnm = 0.1, DynamicMomentum = true) annotation(
    Placement(transformation(origin = {-263, -27}, extent = {{-19, -19}, {19, 19}}, rotation = -90)));
  ThermoPower.Thermal.MetalTubeFV lllllllll(L = 12.9, Nt = 359, Nw = 9, Tstartbar = 623.15, lambda = 22, rext = 19.05e-3/2, rhomcm = 4000000, rint = 13.05e-3/2) annotation(
    Placement(transformation(origin = {-182, -132}, extent = {{-18, -18}, {18, 18}}, rotation = -90)));
  ThermoPower.Thermal.CounterCurrentFV counterCurrentFV(Nw = 9) annotation(
    Placement(transformation(origin = {-222.886, -131.949}, extent = {{-18.9487, -22.2286}, {18.9487, 22.2286}}, rotation = -90)));
  ThermoPower.Thermal.MetalTubeFV lllllll(L = 10.2, Nt = 359, Nw = 9, Tstartbar = 723.15, lambda = 22, rext = 19.05e-3/2, rhomcm = 4000000, rint = 13.05e-3/2) annotation(
    Placement(transformation(origin = {-182, -80}, extent = {{-18, -18}, {18, 18}}, rotation = -90)));
  ThermoPower.Thermal.CounterCurrentFV counterCurrentFV1(Nw = 9) annotation(
    Placement(transformation(origin = {-223, -80.102}, extent = {{-19.102, -24}, {19.102, 24}}, rotation = -90)));
  ThermoPower.Thermal.MetalTubeFV llllll(L = 6.9, Nt = 359, Nw = 9, Tstartbar = 873.15, lambda = 22, rext = 19.05e-3/2, rhomcm = 4000000, rint = 13.05e-3/2) annotation(
    Placement(transformation(origin = {-182, -26}, extent = {{-18, -18}, {18, 18}}, rotation = -90)));
  ThermoPower.Thermal.CounterCurrentFV counterCurrentFV2(Nw = 9) annotation(
    Placement(transformation(origin = {-222.41, -26.2989}, extent = {{-18.8682, -27.1201}, {18.8682, 27.1201}}, rotation = -90)));
  ThermoPower.Electrical.Generator generator(Pnom(displayUnit = "MW") = 6.55e7, referenceGenerator = true, fstart = 60, Np = 1) annotation(
    Placement(transformation(origin = {172, -14}, extent = {{-14, -14}, {14, 14}})));
  ThermoPower.Water.FlowSplit flowSplit annotation(
    Placement(transformation(origin = {46, 20}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
  ThermoPower.Water.Pump CdPump(dp0(displayUnit = "MPa") = 1.41e6, redeclare function efficiencyCharacteristic = ThermoPower.Functions.PumpCharacteristics.constantEfficiency(eta_nom = 0.85), redeclare function flowCharacteristic = ThermoPower.Functions.PumpCharacteristics.quadraticFlow(head_nom = {300.72743947238007, 146.23388533741434, 105.87333298428797}, q_nom = {0, 0.054870609296703905, 0.07133179208571508}), hstart = 193516, n0 = 1800, rho0(displayUnit = "kg/m3") = 983.13, w0 = 54.008, use_in_n = true) annotation(
    Placement(transformation(origin = {139, -169}, extent = {{17, -17}, {-17, 17}})));
  ThermoPower.Water.Pump FwPump(dp0(displayUnit = "MPa") = 1.3312e7, redeclare function efficiencyCharacteristic = ThermoPower.Functions.PumpCharacteristics.constantEfficiency(eta_nom = 0.85), redeclare function flowCharacteristic = ThermoPower.Functions.PumpCharacteristics.quadraticFlow(head_nom = {3085.5366742612923, 1561.0976244723518, 1130.2346801179826}, q_nom = {0, 0.07947880436649801, 0.10332244567644742}), hstart = 856795, n0 = 1800, rho0(displayUnit = "kg/m3") = 869.24, w0 = 69.08, use_in_n = true) annotation(
    Placement(transformation(origin = {-59, -187}, extent = {{17, -17}, {-17, 17}})));
  ThermoPower.Gas.Flow1DFV hotDuct(A = 0.78, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Kfnom, L = 5, redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He, N = 5, Nt = 1, Tstartbar = 1023.15, dpnom(displayUnit = "Pa") = 3000, e = 0.00015, omega = 1*3.14, pstart(displayUnit = "MPa") = 6e6, wnom = 81.6, wnf = 0.5, wnm = 0.1, Dhyd = 1, Kfnom = 2, DynamicMomentum = true) annotation(
    Placement(transformation(origin = {-445, -93}, extent = {{-19, -19}, {19, 19}})));
  ThermoPower.Gas.Flow1DFV coldDuct(A = 0.78, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Kfnom, L = 5, redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He, N = 5, Nt = 1, Tstartbar = 598.15, dpnom(displayUnit = "Pa") = 3000, e = 0.00015, omega = 0.41*3.14, pstart(displayUnit = "MPa") = 6e6, wnom = 81.6, wnf = 0.5, wnm = 0.1, Dhyd = 0.41, Kfnom = 2, noInitialPressure = true, DynamicMomentum = true) annotation(
    Placement(transformation(origin = {-445, -143}, extent = {{19, -19}, {-19, 19}})));
  ThermoPower.customModel.Models.Fan Blower(redeclare function efficiencyCharacteristic = ThermoPower.Functions.PumpCharacteristics.constantEfficiency(eta_nom = 0.85), rho0(displayUnit = "kg/m3") = 4.77, n0 = 1800, w0 = 81.6, dp0(displayUnit = "Pa") = 1.8e5, redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He, redeclare function flowCharacteristic = ThermoPower.Functions.FanCharacteristics.quadraticFlow(H_nom = {64854.44254405128, 37753.17324575091, 27333.29742992366}, q_nom = {0, 17.11477187140708, 22.249203432829205}), use_in_n = true) annotation(
    Placement(transformation(origin = {-359, -175}, extent = {{17, -17}, {-17, 17}})));
  ThermoPower.Gas.Header lowerPlenum(redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He, Tmstart = 598.15, V = 62.59, pstart(displayUnit = "MPa") = 6e6, Tstart = 598.15) annotation(
    Placement(transformation(origin = {-574, -156}, extent = {{22, -22}, {-22, 22}})));
  ThermoPower.Gas.Header upperPlenum(redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He, Tmstart = 598.15, Tstart = 598.15, V = 53.88, pstart(displayUnit = "MPa") = 6e6) annotation(
    Placement(transformation(origin = {-576, 56}, extent = {{-22, -22}, {22, 22}})));
  ThermoPower.Water.ValveVap xxxx(CvData = ThermoPower.Choices.Valve.CvTypes.OpPoint, useThetaInput = true, theta_fix = 0.85, pnom(displayUnit = "Pa") = 1.43e7, dpnom(displayUnit = "Pa") = 5e5, wnom = 69.08, rhonom(displayUnit = "kg/m3") = 41.35, thetanom = 0.85, redeclare function FlowChar = ThermoPower.Functions.ValveCharacteristics.quadratic) annotation(
    Placement(transformation(origin = {-84, 2}, extent = {{-8, -8}, {8, 8}})));
  ThermoPower.Water.ValveVap valve_extraction(CvData = ThermoPower.Choices.Valve.CvTypes.OpPoint, dpnom(displayUnit = "Pa") = 143000, pnom(displayUnit = "Pa") = 1.573e6, rhonom(displayUnit = "kg/m3") = 6.719, theta_fix = 0.5, thetanom = 0.5, useThetaInput = false, wnom = 15.079, redeclare function FlowChar = ThermoPower.Functions.ValveCharacteristics.quadratic) annotation(
    Placement(transformation(origin = {42, -78}, extent = {{-8, 8}, {8, -8}}, rotation = 270)));
  ThermoPower.Gas.SensT1 l(redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He) annotation(
    Placement(transformation(origin = {-263, 53}, extent = {{-17, -17}, {17, 17}})));
  ThermoPower.Water.SensP lll annotation(
    Placement(transformation(origin = {-144, 54}, extent = {{16, -16}, {-16, 16}})));
  ThermoPower.Water.SensT1 lllll annotation(
    Placement(transformation(origin = {-99, 53}, extent = {{17, -17}, {-17, 17}})));
  ThermoPower.customModel.Models.Deaerator Deaerator(V = 25, pstart(displayUnit = "MPa") = 1.43e6) annotation(
    Placement(transformation(origin = {15, -133}, extent = {{15, -15}, {-15, 15}})));
  ThermoPower.customModel.Models.SteamTurbineStodolaEta HPTB(Kt = 0.00296, PRstart = 8.773, eta_iso_nom = 0.85, pnom(displayUnit = "MPa") = 1.38e7, useMflowCorrection = true, useWetnessCorrection = true, wnom = 69.08) annotation(
    Placement(transformation(origin = {-4, -14}, extent = {{-20, -20}, {20, 20}})));
  ThermoPower.customModel.Models.SteamTurbineStodolaEta LPTB(Kt = 0.01661, PRstart = 78.65, eta_iso_nom = 0.85, pnom(displayUnit = "MPa") = 1.573e6, useMflowCorrection = true, useWetnessCorrection = true, wnom = 54.008) annotation(
    Placement(transformation(origin = {82, -14}, extent = {{-20, -20}, {20, 20}})));
  ThermoPower.customModel.Models.Grid_v grid_v(Pgrid(displayUnit = "W") = 65.5e6, pset_const = 65.5e6, use_in_pset = true) annotation(
    Placement(transformation(origin = {280, -14}, extent = {{-18, -18}, {18, 18}})));
  ThermoPower.Electrical.FrequencySensor xxx annotation(
    Placement(transformation(origin = {231, 37}, extent = {{-11, -11}, {11, 11}}, rotation = 90)));
  ThermoPower.Gas.Flow1DFV riser(A = 3.74, Dhyd = 0.54, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Kfnom, Kfnom = 2, L = 8, redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He, N = 5, Nt = 1, Tstartbar = 598.15, dpnom(displayUnit = "Pa") = 3000, e = 0.00015, omega = 0.54*3.14, pstart(displayUnit = "MPa") = 6e6, wnf = 0.5, wnm = 0.1, wnom = 81.6, noInitialPressure = true, DynamicMomentum = true) annotation(
    Placement(transformation(origin = {-625, -55}, extent = {{19, 19}, {-19, -19}}, rotation = -90)));
  ThermoPower.customModel.Models.Condenser_ACC lllllllllllllll(cm = 500, condExchSurface = 4802.84, condNomFlowRate = 54.008, condNomPressure(displayUnit = "kPa") = 2e4, condVol = 26.415, coolExchSurface = 105837, coolNomFlowRate = 7433.86, coolNomPressure = 1e5, coolVol = 4157, gamma_cond = 15e3, gamma_cool = 42, metalVol = 141, pstart_cond(displayUnit = "kPa") = 2e4, rhoMetal(displayUnit = "kg/m3") = 8000) annotation(
    Placement(transformation(origin = {183, -107}, extent = {{-15, -15}, {15, 15}})));
  ThermoPower.Gas.SourceMassFlow xx(redeclare package Medium = Modelica.Media.Air.SimpleAir, T = 298.15, p0 = 1e5, w0 = 7433.86) annotation(
    Placement(transformation(origin = {247, -133}, extent = {{13, -13}, {-13, 13}})));
  ThermoPower.Gas.SinkPressure x(redeclare package Medium = Modelica.Media.Air.SimpleAir, T = 313.15, p0 = 1e5) annotation(
    Placement(transformation(origin = {247, -73}, extent = {{-13, -13}, {13, 13}})));
  // Sensor/actuator buses and nested controller wrapper
  ThermoPower.customModel.Interfaces.SensorBus Sensors annotation(
    Placement(transformation(origin = {-203, 191}, extent = {{-21, -21}, {21, 21}}), iconTransformation(origin = {-200, 160}, extent = {{-10, -10}, {10, 10}})));
  ThermoPower.customModel.Interfaces.ActuatorBus Actuators annotation(
    Placement(transformation(origin = {-321, 189}, extent = {{-21, -21}, {21, 21}}), iconTransformation(origin = {0, 160}, extent = {{-10, -10}, {10, 10}})));
  DataCenterLoadIcon dcLoad annotation(
    Placement(transformation(origin = {341, 37}, extent = {{23, -23}, {-23, 23}})));
  ReactorCore reactorCore annotation(
    Placement(transformation(origin = {-509, -1}, extent = {{-37, -37}, {37, 37}})));
equation
// -------------------------------------------------------------------------
// Sensor signals -> SensorBus
// -------------------------------------------------------------------------
// SensorBus -> control wrapper
// Control wrapper -> ActuatorBus
// -------------------------------------------------------------------------
// ActuatorBus -> plant actuators
// -------------------------------------------------------------------------
  connect(coldDuct.outfl, lowerPlenum.inlet) annotation(
    Line(points = {{-464, -143}, {-498, -143}, {-498, -156}, {-552, -156}}, color = {159, 159, 223}, thickness = 1.5));
  connect(lowerPlenum.outlet, riser.infl) annotation(
    Line(points = {{-596, -156}, {-625, -156}, {-625, -74}}, color = {159, 159, 223}, thickness = 1.5));
  connect(riser.outfl, upperPlenum.inlet) annotation(
    Line(points = {{-625, -36}, {-625, 56}, {-598, 56}}, color = {159, 159, 223}, thickness = 1.5));
  connect(superheater_primary.outfl, evaporator_primary.infl) annotation(
    Line(points = {{-263, -46}, {-263, -62}}, color = {159, 159, 223}, thickness = 1.5));
  connect(evaporator_primary.outfl, economizer_primary.infl) annotation(
    Line(points = {{-263, -100}, {-263, -114}}, color = {159, 159, 223}, thickness = 1.5));
  connect(economizer_primary.outfl, Blower.infl) annotation(
    Line(points = {{-263, -152}, {-310, -152}, {-310, -171}, {-345, -171}}, color = {159, 159, 223}, thickness = 1.5));
  connect(Blower.outfl, coldDuct.infl) annotation(
    Line(points = {{-369.2, -162.76}, {-412.2, -162.76}, {-412.2, -141.76}, {-426.2, -141.76}}, color = {159, 159, 223}, thickness = 1.5));
  connect(superheater_primary.infl, l.flange) annotation(
    Line(points = {{-263, -8}, {-263, 46}}, color = {159, 159, 223}, thickness = 1.5));
  connect(hotDuct.outfl, superheater_primary.infl) annotation(
    Line(points = {{-426, -93}, {-352, -93}, {-352, 11}, {-262, 11}, {-262, -9}}, color = {159, 159, 223}, thickness = 1.5));
  connect(superheater_primary.wall, counterCurrentFV2.side2) annotation(
    Line(points = {{-253.5, -27}, {-230.5, -27}}, color = {255, 127, 0}, thickness = 1.5));
  connect(evaporator_primary.wall, counterCurrentFV1.side2) annotation(
    Line(points = {{-253.5, -81}, {-229.5, -81}}, color = {255, 127, 0}, thickness = 1.5));
  connect(economizer_primary.wall, counterCurrentFV.side2) annotation(
    Line(points = {{-253.5, -133}, {-229.5, -133}}, color = {255, 127, 0}, thickness = 1.5));
  connect(counterCurrentFV2.side1, llllll.ext) annotation(
    Line(points = {{-214.274, -26.2989}, {-188.274, -26.2989}}, color = {255, 127, 0}, thickness = 1.5));
  connect(counterCurrentFV1.side1, lllllll.ext) annotation(
    Line(points = {{-215.8, -80.102}, {-187.8, -80.102}}, color = {255, 127, 0}, thickness = 1.5));
  connect(counterCurrentFV.side1, lllllllll.ext) annotation(
    Line(points = {{-216.217, -131.949}, {-188.217, -131.949}}, color = {255, 127, 0}, thickness = 1.5));
  connect(superheater_secondary.infl, evaporator_secondary.outfl) annotation(
    Line(points = {{-144, -44}, {-144, -62}}, color = {0, 0, 255}, thickness = 1.5));
  connect(evaporator_secondary.infl, economizer_secondary.outfl) annotation(
    Line(points = {{-144, -98}, {-144, -114}}, color = {0, 0, 255}, thickness = 1.5));
  connect(llllll.int, superheater_secondary.wall) annotation(
    Line(points = {{-176.6, -26}, {-153, -26}}, color = {255, 127, 0}, thickness = 1.5));
  connect(lllllll.int, evaporator_secondary.wall) annotation(
    Line(points = {{-176.6, -80}, {-153, -80}}, color = {255, 127, 0}, thickness = 1.5));
  connect(lllllllll.int, economizer_secondary.wall) annotation(
    Line(points = {{-176.6, -132}, {-153, -132}}, color = {255, 127, 0}, thickness = 1.5));
  connect(l.T, Sensors) annotation(
    Line(points = {{-251.1, 63.2}, {-203.1, 63.2}, {-203.1, 191.2}}, color = {255, 170, 0}, thickness = 1.5));
  connect(Actuators, Blower.in_n) annotation(
    Line(points = {{-321, 189}, {-322, 189}, {-322, -140}, {-358, -140}, {-358, -162}}, color = {170, 0, 255}, thickness = 1.5));
  connect(superheater_secondary.outfl, xxxx.inlet) annotation(
    Line(points = {{-144, -8}, {-144, 2}, {-92, 2}}, color = {0, 0, 255}, thickness = 1.5));
  connect(xxxx.outlet, HPTB.inlet) annotation(
    Line(points = {{-76, 2}, {-20, 2}}, color = {0, 0, 255}, thickness = 1.5));
  connect(HPTB.outlet, flowSplit.in1) annotation(
    Line(points = {{12, 2}, {28, 2}, {28, 34}, {46, 34}, {46, 26}}, color = {0, 0, 255}, thickness = 1.5));
  connect(flowSplit.out2, LPTB.inlet) annotation(
    Line(points = {{50, 14}, {50, 2}, {66, 2}}, color = {0, 0, 255}, thickness = 1.5));
  connect(valve_extraction.outlet, Deaerator.SteamIn) annotation(
    Line(points = {{42, -86}, {41.5, -86}, {41.5, -124}, {27, -124}}, color = {0, 0, 255}, thickness = 1.5));
  connect(flowSplit.out1, valve_extraction.inlet) annotation(
    Line(points = {{42, 14}, {42, -70}}, color = {0, 0, 255}, thickness = 1.5));
  connect(CdPump.infl, lllllllllllllll.waterOut) annotation(
    Line(points = {{152.6, -165.6}, {181.2, -165.6}, {181.2, -121.2}}, color = {0, 0, 255}, thickness = 1.5));
  connect(xx.flange, lllllllllllllll.coolingIn) annotation(
    Line(points = {{234, -133}, {212, -133}, {212, -112}, {198, -112}}, color = {159, 159, 223}, thickness = 1.5));
  connect(lllllllllllllll.coolingOut, x.flange) annotation(
    Line(points = {{198, -98}, {212, -98}, {212, -73}, {234, -73}}, color = {159, 159, 223}, thickness = 1.5));
  connect(HPTB.shaft_b, LPTB.shaft_a) annotation(
    Line(points = {{8.8, -14}, {68.8, -14}}, thickness = 1.5));
  connect(LPTB.shaft_b, generator.shaft) annotation(
    Line(points = {{94.8, -14}, {160.8, -14}}, thickness = 1.5));
  connect(LPTB.outlet, lllllllllllllll.steamIn) annotation(
    Line(points = {{98, 2}, {120, 2}, {120, -72}, {182, -72}, {182, -92}}, color = {0, 0, 255}, thickness = 1.5));
  connect(generator.port, grid_v.port) annotation(
    Line(points = {{184.04, -14}, {265, -14}}, thickness = 1.5));
  connect(xxx.f, Sensors) annotation(
    Line(points = {{231, 48.22}, {231, 98.22}, {-203, 98.22}, {-203, 191.22}}, color = {255, 170, 0}, thickness = 1.5));
  connect(lllllllllllllll.ratio_VvonVtot, Sensors) annotation(
    Line(points = {{168, -105.5}, {112, -105.5}, {112, 98}, {-203, 98}, {-203, 191}}, color = {255, 170, 0}, thickness = 1.5));
  connect(grid_v.port, xxx.port) annotation(
    Line(points = {{264.52, -14}, {231.04, -14}, {231.04, 26}, {230.04, 26}}, thickness = 1.5));
  connect(FwPump.in_n, Actuators) annotation(
    Line(points = {{-54.58, -173.4}, {-54.58, 133.6}, {-321, 133.6}, {-321, 189}}, color = {170, 0, 255}, thickness = 1.5));
  connect(xxxx.theta, Actuators) annotation(
    Line(points = {{-84, 8.4}, {-84, 134.4}, {-321, 134.4}, {-321, 189}}, color = {170, 0, 255}, thickness = 1.5));
  connect(dcLoad.P_load, grid_v.pset) annotation(
    Line(points = {{315.7, 37}, {274.4, 37}, {274.4, 0}}, thickness = 1.5));
  connect(FwPump.infl, Deaerator.CondOut) annotation(
    Line(points = {{-45.4, -183.6}, {-23.4, -183.6}, {-23.4, -131.6}, {0.6, -131.6}}, color = {0, 0, 255}, thickness = 1.5));
  connect(Deaerator.WaterIn, CdPump.outfl) annotation(
    Line(points = {{27, -142}, {128, -142}, {128, -157}}, color = {0, 0, 255}, thickness = 1.5));
  connect(CdPump.in_n, Actuators) annotation(
    Line(points = {{143.42, -155.4}, {143.42, 134.6}, {-320.58, 134.6}, {-320.58, 190.6}}, color = {170, 0, 255}, thickness = 1.5));
  connect(FwPump.outfl, economizer_secondary.infl) annotation(
    Line(points = {{-70, -176}, {-72, -176}, {-72, -164}, {-144, -164}, {-144, -150}}, color = {0, 0, 255}));
  connect(superheater_secondary.outfl, lll.flange) annotation(
    Line(points = {{-144, -8}, {-144, 48}}, color = {0, 0, 255}, thickness = 1.5));
  connect(superheater_secondary.outfl, lllll.flange) annotation(
    Line(points = {{-144, -8}, {-144, 22}, {-99, 22}, {-99, 46}}, color = {0, 0, 255}, thickness = 1.5));
  connect(lllll.T, Sensors) annotation(
    Line(points = {{-112, 64}, {-114, 64}, {-114, 98}, {-202, 98}, {-202, 192}}, color = {255, 170, 0}, thickness = 1.5));
  connect(lll.p, Sensors) annotation(
    Line(points = {{-156, 64}, {-158, 64}, {-158, 98}, {-202, 98}, {-202, 192}}, color = {255, 170, 0}, thickness = 1.5));
  connect(upperPlenum.outlet, reactorCore.inlet) annotation(
    Line(points = {{-554, 56}, {-509, 56}, {-509, 36}}, color = {159, 159, 223}, thickness = 1.5));
  connect(reactorCore.outlet, hotDuct.infl) annotation(
    Line(points = {{-509, -38}, {-509, -92}, {-464, -92}}, color = {159, 159, 223}, thickness = 1.5));
  connect(reactorCore.actuatorSignal, Actuators) annotation(
    Line(points = {{-476, -4}, {-408, -4}, {-408, 134}, {-320, 134}, {-320, 190}}, color = {170, 0, 255}, thickness = 1.5));
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
end Figure_Full_Rxmodule;
