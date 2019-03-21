within OU44Emulator.SingleZone;
model AirHandlingUnit
  Buildings.Fluid.Movers.SpeedControlled_y fanSu(
    addPowerToMedium=false,
    redeclare package Medium = Air,
    redeclare Data.AhuFanx4 per,
    allowFlowReversal=true)
    annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
  Buildings.Fluid.Sensors.VolumeFlowRate senVolFloIn(
                                               redeclare package Medium = Air,
    m_flow_nominal=m_flow_nominal,
    allowFlowReversal=true)
    annotation (Placement(transformation(extent={{20,-50},{40,-30}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTemIn2(
                                                      redeclare package Medium
      = Air,
    m_flow_nominal=m_flow_nominal,
    allowFlowReversal=true)
    annotation (Placement(transformation(extent={{-36,-50},{-16,-30}})));
  Buildings.Fluid.HeatExchangers.ConstantEffectiveness hex(
    eps=0.8,
    redeclare package Medium1 = Air,
    redeclare package Medium2 = Air,
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    m1_flow_nominal=m_flow_nominal,
    m2_flow_nominal=m_flow_nominal,
    dp1_nominal=150,
    dp2_nominal=150)
    annotation (Placement(transformation(extent={{-46,-10},{-66,10}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTemEx1(
                                                      redeclare package Medium
      = Air,
    allowFlowReversal=false,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-18,30},{-38,50}})));
  Buildings.Fluid.Sensors.VolumeFlowRate senVolFloEx(
                                               redeclare package Medium = Air,
    allowFlowReversal=false,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{48,30},{28,50}})));
  Buildings.Fluid.Sensors.Pressure senPreIn(redeclare package Medium = Air)
    annotation (Placement(transformation(extent={{120,-40},{140,-20}})));
  Buildings.Fluid.Sensors.Pressure senPreEx(redeclare package Medium = Air)
    annotation (Placement(transformation(extent={{102,40},{122,60}})));
  Buildings.Fluid.Movers.SpeedControlled_y fanEx(
    addPowerToMedium=false,
    redeclare package Medium = Air,
    allowFlowReversal=false,
    redeclare Data.AhuFanx4 per)
    annotation (Placement(transformation(extent={{20,30},{0,50}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTemEx2(
                                                      redeclare package Medium
      = Air,
    allowFlowReversal=false,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-80,30},{-100,50}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTemIn1(
                                                      redeclare package Medium
      = Air,
    m_flow_nominal=m_flow_nominal,
    allowFlowReversal=true)
    annotation (Placement(transformation(extent={{-100,-50},{-80,-30}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTemIn3(
                                                      redeclare package Medium
      = Air,
    allowFlowReversal=false,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{98,-50},{118,-30}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b1(redeclare package Medium = Air)
    annotation (Placement(transformation(extent={{150,-50},{170,-30}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare package Medium = Air)
    annotation (Placement(transformation(extent={{150,30},{170,50}})));
  Modelica.Blocks.Interfaces.RealInput y annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={-60,110})));
  replaceable package Air = Buildings.Media.Air constrainedby
    Modelica.Media.Interfaces.PartialMedium;
  replaceable package Water = Buildings.Media.Water constrainedby
    Modelica.Media.Interfaces.PartialMedium;
  Modelica.Blocks.Interfaces.RealOutput qel annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-100,-106})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{-60,-84},{-80,-64}})));
  Buildings.Fluid.Sources.Outside outEx(nPorts=1, redeclare package Medium =
        Air)
    annotation (Placement(transformation(extent={{-140,30},{-120,50}})));
  Buildings.Fluid.Sources.Outside outSu(nPorts=1, redeclare package Medium =
        Air)
    annotation (Placement(transformation(extent={{-140,-50},{-120,-30}})));
  Buildings.BoundaryConditions.WeatherData.Bus weaBus annotation (Placement(
        transformation(extent={{-180,-22},{-140,18}}), iconTransformation(
          extent={{-200,104},{-180,124}})));
  Buildings.Fluid.HeatExchangers.ConstantEffectiveness hex1(redeclare package
      Medium1 = Air,
    redeclare package Medium2 = Water,
    eps=0.95,
    m1_flow_nominal=m_flow_nominal,
    m2_flow_nominal=m2_flow_nominal,
    dp1_nominal=5,
    dp2_nominal=5)
    annotation (Placement(transformation(extent={{60,-56},{80,-36}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a2(redeclare package Medium =
        Water)
    annotation (Placement(transformation(extent={{90,-110},{110,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b2(redeclare package Medium =
        Water)
    annotation (Placement(transformation(extent={{30,-110},{50,-90}})));
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal=31
    "Nominal mass flow rate - air";
  parameter Modelica.SIunits.MassFlowRate m2_flow_nominal=0.01
    "Nominal mass flow rate - water";
  Modelica.Blocks.Interfaces.RealOutput Tsu annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={166,-80})));
equation
  connect(fanSu.port_b, senVolFloIn.port_a)
    annotation (Line(points={{10,-40},{20,-40}}, color={0,127,255}));
  connect(fanSu.port_a, senTemIn2.port_b)
    annotation (Line(points={{-10,-40},{-16,-40}}, color={0,127,255}));
  connect(senTemIn2.port_a, hex.port_b2) annotation (Line(points={{-36,-40},{
          -40,-40},{-40,-6},{-46,-6}}, color={0,127,255}));
  connect(senTemEx1.port_b, hex.port_a1) annotation (Line(points={{-38,40},{-40,
          40},{-40,6},{-46,6}},     color={0,127,255}));
  connect(senVolFloEx.port_a, senPreEx.port)
    annotation (Line(points={{48,40},{112,40}}, color={0,127,255}));
  connect(senVolFloEx.port_b, fanEx.port_a)
    annotation (Line(points={{28,40},{20,40}}, color={0,127,255}));
  connect(fanEx.port_b, senTemEx1.port_a)
    annotation (Line(points={{0,40},{-18,40}}, color={0,127,255}));
  connect(hex.port_b1, senTemEx2.port_a) annotation (Line(points={{-66,6},{
          -72,6},{-72,40},{-80,40}}, color={0,127,255}));
  connect(hex.port_a2, senTemIn1.port_b) annotation (Line(points={{-66,-6},{-72,
          -6},{-72,-40},{-80,-40}},     color={0,127,255}));
  connect(senPreIn.port, senTemIn3.port_b)
    annotation (Line(points={{130,-40},{118,-40}}, color={0,127,255}));
  connect(port_b1, port_b1)
    annotation (Line(points={{160,-40},{160,-40}}, color={0,127,255}));
  connect(senPreEx.port, port_a1)
    annotation (Line(points={{112,40},{160,40}}, color={0,127,255}));
  connect(y, fanSu.y) annotation (Line(points={{-60,110},{-60,18},{0,18},{0,-28}},
        color={0,0,127}));
  connect(senPreIn.port, port_b1) annotation (Line(points={{130,-40},{160,-40}},
                                color={0,127,255}));
  connect(fanEx.y, y) annotation (Line(points={{10,52},{10,72},{-60,72},{-60,
          110}},
        color={0,0,127}));
  connect(add.y, qel) annotation (Line(points={{-81,-74},{-100,-74},{-100,-106}},
        color={0,0,127}));
  connect(fanEx.P, add.u1) annotation (Line(points={{-1,49},{-1,50},{-10,50},
          {-10,-18},{-48,-18},{-48,-68},{-58,-68}},
                                               color={0,0,127}));
  connect(fanSu.P, add.u2) annotation (Line(points={{11,-31},{15.5,-31},{15.5,-80},
          {-58,-80}}, color={0,0,127}));
  connect(senTemEx2.port_b, outEx.ports[1])
    annotation (Line(points={{-100,40},{-120,40}}, color={0,127,255}));
  connect(senTemIn1.port_a, outSu.ports[1])
    annotation (Line(points={{-100,-40},{-120,-40}}, color={0,127,255}));
  connect(weaBus, outEx.weaBus) annotation (Line(
      points={{-160,-2},{-150,-2},{-150,4},{-140,4},{-140,40.2}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(weaBus, outSu.weaBus) annotation (Line(
      points={{-160,-2},{-150,-2},{-150,-6},{-140,-6},{-140,-39.8}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(senVolFloIn.port_b, hex1.port_a1)
    annotation (Line(points={{40,-40},{60,-40}}, color={0,127,255}));
  connect(hex1.port_b1, senTemIn3.port_a)
    annotation (Line(points={{80,-40},{98,-40}}, color={0,127,255}));
  connect(port_a2, hex1.port_a2) annotation (Line(points={{100,-100},{100,-72},{
          80,-72},{80,-52}}, color={0,127,255}));
  connect(port_b2, hex1.port_b2) annotation (Line(points={{40,-100},{40,-72},{60,
          -72},{60,-52}}, color={0,127,255}));
  connect(senTemIn3.T, Tsu) annotation (Line(points={{108,-29},{108,-20},{120,
          -20},{120,-80},{166,-80}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,
            -100},{160,100}}), graphics={
        Rectangle(
          extent={{-160,100},{160,-100}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(extent={{-20,60},{20,20}}, lineColor={28,108,200}),
        Line(points={{12,56},{12,24},{-20,40},{12,56}}, color={28,108,200}),
        Ellipse(extent={{-20,-20},{20,-60}}, lineColor={28,108,200}),
        Line(points={{-12,-24},{-12,-56},{20,-40},{-12,-24}}, color={28,108,200}),
        Line(points={{20,-40},{150,-40}}, color={28,108,200}),
        Line(points={{-20,-40},{-150,-40}}, color={28,108,200}),
        Line(points={{-150,40},{-20,40}}, color={28,108,200}),
        Line(points={{20,40},{150,40}}, color={28,108,200}),
        Line(points={{-82,40},{-122,-40}}, color={28,108,200}),
        Line(points={{-122,40},{-82,-40}}, color={28,108,200}),
        Rectangle(
          extent={{62,-20},{82,-60}},
          lineColor={28,108,200},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid),
        Line(points={{0,72},{0,60}}, color={0,0,0}),
        Line(points={{-60,90},{-60,-10},{0,-10},{0,-20}},
                                                      color={0,0,0}),
        Line(points={{0,72},{-60,72}}, color={0,0,0}),
        Line(
          points={{2,-60},{2,-74},{-100,-74},{-100,-96}},
          color={0,0,0},
          pattern=LinePattern.Dash),
        Line(
          points={{0,20},{0,12},{-40,12},{-40,-74}},
          color={0,0,0},
          pattern=LinePattern.Dash),
        Line(points={{-150,44},{-150,36}}, color={28,108,200}),
        Line(points={{-150,-36},{-150,-44}}, color={28,108,200}),
        Line(points={{100,-90},{100,-54},{82,-54}}, color={238,46,47}),
        Line(points={{62,-54},{40,-54},{40,-90}}, color={28,108,200}),
        Line(
          points={{156,-80},{130,-80},{130,-40}},
          color={0,140,72},
          pattern=LinePattern.Dash)}),
                                Diagram(coordinateSystem(preserveAspectRatio=
            false, extent={{-160,-100},{160,100}})));
end AirHandlingUnit;
