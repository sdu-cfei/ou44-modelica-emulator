within OU44Emulator.SingleZone;
model DistrictHeating
  replaceable package Water = Buildings.Media.Water constrainedby
    Modelica.Media.Interfaces.PartialMedium;
  Buildings.Fluid.HeatExchangers.ConstantEffectiveness dhHX(
    redeclare package Medium1 = Water,
    redeclare package Medium2 = Water,
    m1_flow_nominal=m_flow_nominal,
    m2_flow_nominal=m_flow_nominal,
    dp1_nominal=5,
    dp2_nominal=5,
    eps=0.8)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Buildings.Fluid.HeatExchangers.Heater_T hea(
    redeclare package Medium = Water,
    m_flow_nominal=m_flow_nominal,
    dp_nominal=0)
    annotation (Placement(transformation(extent={{-10,-78},{10,-58}})));
  Modelica.Blocks.Sources.Constant dhTemp(k=273.15 + 65)
    annotation (Placement(transformation(extent={{-90,-70},{-70,-50}})));
  Modelica.Blocks.Interfaces.RealOutput qdh "District heating power [W]"
    annotation (Placement(transformation(extent={{96,-70},{116,-50}})));
  Modelica.Blocks.Sources.Constant dhPmpSp(k=1)
    annotation (Placement(transformation(extent={{-10,-48},{10,-28}})));
  Buildings.Fluid.Sensors.VolumeFlowRate senVolFloDH(redeclare package Medium
      = Water, m_flow_nominal=m_flow_nominal) annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-50,-38})));
  Buildings.Fluid.Storage.ExpansionVessel exp(redeclare package Medium = Water,
      V_start=0.3)
                  annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-80,-6})));
  Buildings.Fluid.Sensors.TemperatureTwoPort tDHRe(redeclare package Medium =
        Water, m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-26,-16},{-46,4}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort tSu(redeclare package Medium =
        Water, m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{34,-4},{54,16}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium = Water)
    annotation (Placement(transformation(extent={{-70,90},{-50,110}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium = Water)
    annotation (Placement(transformation(extent={{50,90},{70,110}})));
  Buildings.Fluid.Movers.SpeedControlled_y pmp2(
    redeclare package Medium = Water,
    addPowerToMedium=false,
    redeclare Buildings.Fluid.Movers.Data.Pumps.Wilo.Stratos40slash1to8 per(
        pressure(V_flow={4.03163741226e-06,0.00188290448506,0.00245068662086,
            0.00286231420438,0.00325508173616,0.00357919645424,
            0.00394696189973}, dp={50361.3292164,50002.6907452,46761.3220062,
            42267.4693149,36095.691563,30066.6880748,23476.280464})))
                              annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-42,38})));
  Modelica.Blocks.Interfaces.RealInput y "Normalized pump speed (indoor loop)"
    annotation (Placement(transformation(extent={{-130,40},{-90,80}})));
  Buildings.Fluid.Sensors.VolumeFlowRate senVolFloSu(redeclare package Medium
      = Water, m_flow_nominal=m_flow_nominal) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={60,38})));
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal=0.01
    "Nominal mass flow rate";
  Buildings.Fluid.Sensors.TemperatureTwoPort tRe(redeclare package Medium =
        Water, m_flow_nominal=m_flow_nominal) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-60,76})));
  Buildings.Fluid.Movers.SpeedControlled_y pmp1(
    redeclare package Medium = Water,
    addPowerToMedium=false,
    redeclare Buildings.Fluid.Movers.Data.Pumps.Wilo.Stratos30slash1to8 per,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState)
                              annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={38,-38})));
  Buildings.Fluid.Sensors.MassFlowRate senMasFloDH(redeclare package Medium =
        Water)
    annotation (Placement(transformation(extent={{-42,-78},{-22,-58}})));
  Buildings.Fluid.Sensors.MassFlowRate senMasFloSu(redeclare package Medium =
        Water) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={60,74})));
  Modelica.Blocks.Interfaces.RealOutput qel
    "Circulation pump electricity consumption [W]"
    annotation (Placement(transformation(extent={{96,50},{116,70}})));
equation
  connect(hea.TSet, dhTemp.y)
    annotation (Line(points={{-12,-60},{-69,-60}}, color={0,0,127}));
  connect(exp.port_a, senVolFloDH.port_a) annotation (Line(points={{-80,-16},{
          -50,-16},{-50,-28}}, color={0,127,255}));
  connect(dhHX.port_b2, tDHRe.port_a)
    annotation (Line(points={{-10,-6},{-26,-6}}, color={0,127,255}));
  connect(tDHRe.port_b, senVolFloDH.port_a) annotation (Line(points={{-46,-6},
          {-50,-6},{-50,-28}}, color={0,127,255}));
  connect(tSu.port_a, dhHX.port_b1)
    annotation (Line(points={{34,6},{10,6}}, color={0,127,255}));
  connect(port_a, port_a)
    annotation (Line(points={{-60,100},{-60,100}}, color={0,127,255}));
  connect(pmp2.port_b, dhHX.port_a1) annotation (Line(points={{-32,38},{-24,38},
          {-24,6},{-10,6}}, color={0,127,255}));
  connect(y, pmp2.y)
    annotation (Line(points={{-110,60},{-42,60},{-42,50}}, color={0,0,127}));
  connect(tSu.port_b, senVolFloSu.port_a)
    annotation (Line(points={{54,6},{60,6},{60,28}}, color={0,127,255}));
  connect(hea.Q_flow, qdh)
    annotation (Line(points={{11,-60},{106,-60}}, color={0,0,127}));
  connect(port_a, tRe.port_a)
    annotation (Line(points={{-60,100},{-60,86}}, color={0,127,255}));
  connect(tRe.port_b, pmp2.port_a)
    annotation (Line(points={{-60,66},{-60,38},{-52,38}}, color={0,127,255}));
  connect(pmp1.port_b, dhHX.port_a2)
    annotation (Line(points={{38,-28},{38,-6},{10,-6}}, color={0,127,255}));
  connect(pmp1.port_a, hea.port_b)
    annotation (Line(points={{38,-48},{38,-68},{10,-68}}, color={0,127,255}));
  connect(pmp1.y, dhPmpSp.y)
    annotation (Line(points={{26,-38},{11,-38}}, color={0,0,127}));
  connect(senVolFloDH.port_b, senMasFloDH.port_a) annotation (Line(points={{
          -50,-48},{-50,-68},{-42,-68}}, color={0,127,255}));
  connect(senMasFloDH.port_b, hea.port_a)
    annotation (Line(points={{-22,-68},{-10,-68}}, color={0,127,255}));
  connect(senVolFloSu.port_b, senMasFloSu.port_a)
    annotation (Line(points={{60,48},{60,64}}, color={0,127,255}));
  connect(senMasFloSu.port_b, port_b)
    annotation (Line(points={{60,84},{60,100}}, color={0,127,255}));
  connect(pmp2.P, qel) annotation (Line(points={{-31,47},{-11.5,47},{-11.5,60},
          {106,60}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-20,20},{20,-20}},
          lineColor={238,46,47},
          fillColor={255,255,255},
          fillPattern=FillPattern.Backward),
        Line(points={{18,-4}}, color={28,108,200}),
        Line(points={{20,0},{60,0},{60,90}}, color={238,46,47}),
        Ellipse(extent={{-74,74},{-46,46}}, lineColor={28,108,200}),
        Line(points={{-60,46},{-72,68},{-48,68},{-60,46}}, color={28,108,200}),
        Line(points={{-60,90},{-60,74}}, color={28,108,200}),
        Line(points={{-60,46},{-60,0},{-20,0}}, color={28,108,200}),
        Line(
          points={{0,-20},{0,-60},{96,-60}},
          color={238,46,47},
          pattern=LinePattern.Dash),
        Line(points={{-90,60},{-74,60}}, color={0,0,0})}),       Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=259200),
    __Dymola_experimentSetupOutput);
end DistrictHeating;
