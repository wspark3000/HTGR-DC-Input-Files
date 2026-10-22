within ThermoPower.customModel.Blocks;

block SuperTwistingSMC_int
  "Super-twisting sliding mode controller with conditional integral action"

  extends Modelica.Blocks.Interfaces.SVcontrol;
  // u_s : setpoint
  // u_m : measurement
  // y   : controller output

  // ============================================================
  // Parameters
  // ============================================================

  parameter Real c = 1.0
    "Sliding surface coefficient";

  parameter Real lambda
    "|s|^0.5 continuous-term gain";

  parameter Real alpha
    "Super-twisting integral gain";

  parameter Real T_C = 0.05
    "Derivative filter time constant";

  parameter Real w_start = 0
    "Initial super-twisting integral state";

  parameter Real phi_lambda(min=1e-8) = 1
    "tanh boundary-layer width for continuous term";

  parameter Real phi_alpha(min=1e-8) = phi_lambda
    "tanh boundary-layer width for integral term";

  parameter Real eps_int(min=0) = 0
    "Integral-action deadband based on |u_s-u_m|; 0 disables deadband";


  // ============================================================
  // Filtered derivative
  // ============================================================

  Modelica.Blocks.Continuous.Derivative derivative(
    k = 1,
    T = T_C,
    initType = Modelica.Blocks.Types.Init.InitialState,
    x_start = 0)
    "Filtered derivative: s/(T_C*s + 1)";


  // ============================================================
  // Internal variables
  // ============================================================

  Real e
    "Tracking error, u_s-u_m";

  Real edot_f
    "Filtered error derivative";

  Real s
    "Sliding surface";

  Real sigma_lambda
    "Smoothed sign function for continuous term";

  Real sigma_alpha
    "Smoothed sign function for integral term";

  Real u_cont
    "Continuous super-twisting term";

  Real w(
    start = w_start,
    fixed = true)
    "Super-twisting integral state";

  Real intGate
    "Integral-action gate: 0 or 1";


equation

  // ============================================================
  // Error
  // ============================================================

  e = u_s - u_m;


  // ============================================================
  // Sliding surface
  //
  // s = c*e + filtered(de/dt)
  // ============================================================

  derivative.u = e;
  edot_f = derivative.y;

  s = c*e + edot_f;


  // ============================================================
  // Smoothed sign functions
  // ============================================================

  sigma_lambda = tanh(s / phi_lambda);

  sigma_alpha = tanh(s / phi_alpha);


  // ============================================================
  // Continuous super-twisting term
  //
  // u_cont = lambda*sqrt(|s|)*tanh(s/phi_lambda)
  // ============================================================

  u_cont =
    lambda
    * sqrt(abs(s))
    * sigma_lambda;


  // ============================================================
  // Conditional integral action
  //
  // eps_int = 0:
  //     conventional super-twisting integral action
  //
  // eps_int > 0:
  //
  //     |e| <= eps_int  -> der(w) = 0
  //     |e| >  eps_int  -> der(w) = alpha*tanh(s/phi_alpha)
  //
  // ============================================================

  intGate =
    if eps_int <= 0 then
      1.0
    else if noEvent(abs(e) > eps_int) then
      1.0
    else
      0.0;

  der(w) =
    alpha
    * sigma_alpha
    * intGate;


  // ============================================================
  // Controller output
  //
  // y = continuous term + integral term
  // ============================================================

  y = u_cont + w;


  annotation(
    Icon(
      coordinateSystem(preserveAspectRatio = true),
      graphics = {
        Rectangle(
          extent = {{-100,-100},{100,100}},
          lineColor = {0,0,127},
          fillColor = {255,255,255},
          fillPattern = FillPattern.Solid),

        Text(
          extent = {{-80,40},{80,-40}},
          textString = "ST-SMC"),

        Text(
          extent = {{-150,150},{150,110}},
          textString = "%name",
          lineColor = {0,0,255})
      }
    ),

    Documentation(info = "
<html>
<p>
Super-twisting sliding-mode controller with smoothed switching functions
and optional conditional integral action.
</p>

<p>
Sliding surface:
</p>

<p>
s = c e + de/dt(filtered)
</p>

<p>
Continuous term:
</p>

<p>
u_cont = lambda sqrt(|s|) tanh(s/phi_lambda)
</p>

<p>
Integral term:
</p>

<p>
dw/dt = alpha tanh(s/phi_alpha)
</p>

<p>
When eps_int &gt; 0, the integral state is frozen for
|e| &lt;= eps_int. The continuous term remains active.
</p>
</html>
"));

end SuperTwistingSMC_int;