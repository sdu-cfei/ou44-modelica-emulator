within OU44Emulator.SingleZone;
model Infiltration "Constant infiltration"
  replaceable package Air = Buildings.Media.Air;
  parameter Modelica.SIunits.Volume Vi "Indoor air volume";
  parameter Real ach=0.33 "Infiltration air changes per hour";
  Buildings.Fluid.Sources.MassFlowSource_WeatherData infiltr(
    redeclare package Medium = Air,
    nPorts=1,
    m_flow=ach*Vi/1.2/3600)
              "Infiltration"
    annotation (Placement(transformation(extent={{-46,50},{-26,70}})));
  Buildings.Fluid.Sensors.VolumeFlowRate senVolFloIn(redeclare package Medium
      = Air, m_flow_nominal=1) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={30,60})));
  Buildings.Fluid.Sources.FixedBoundary bou(redeclare package Medium = Air,
      nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-34,-60})));
  Buildings.Fluid.Sensors.VolumeFlowRate senVolFloOut(redeclare package Medium
      = Air, m_flow_nominal=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={30,-60})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium = Air)
    annotation (Placement(transformation(extent={{90,50},{110,70}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium = Air)
    annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
  Buildings.BoundaryConditions.WeatherData.Bus weaBus annotation (Placement(
        transformation(extent={{-120,40},{-80,80}}), iconTransformation(extent={{-126,50},
            {-106,70}})));
equation
  connect(senVolFloOut.port_a, port_b)
    annotation (Line(points={{40,-60},{100,-60}}, color={0,127,255}));
  connect(senVolFloOut.port_b, bou.ports[1])
    annotation (Line(points={{20,-60},{-24,-60}}, color={0,127,255}));
  connect(senVolFloIn.port_b, port_a) annotation (Line(points={{40,60},{70,60},
          {70,60},{100,60}}, color={0,127,255}));
  connect(senVolFloIn.port_a, infiltr.ports[1])
    annotation (Line(points={{20,60},{-26,60}}, color={0,127,255}));
  connect(weaBus, infiltr.weaBus) annotation (Line(
      points={{-100,60},{-72,60},{-72,60.2},{-46,60.2}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-8,80},{8,-80}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-60,20},{-20,0},{20,20},{60,0}},
          color={28,108,200},
          smooth=Smooth.Bezier),
        Line(
          points={{-60,50},{-20,30},{20,50},{60,30}},
          color={28,108,200},
          smooth=Smooth.Bezier),
        Line(
          points={{-60,-10},{-20,-30},{20,-10},{60,-30}},
          color={28,108,200},
          smooth=Smooth.Bezier)}),                               Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Infiltration;
