within OU44Emulator.Models;
partial model BuildingBase "Single-zone whole building model"
package Water = Buildings.Media.Water;
package Air = Buildings.Media.Air(extraPropertiesNames={"CO2"});
final parameter Modelica.SIunits.Area AFlo=8500 "Floor area";
final parameter Modelica.SIunits.Length hRoo=3.2 "Average room height";
final parameter Modelica.SIunits.MassFlowRate m_flow_nominal_water=5
  "Nominal mass flow rate for water loop";
final parameter Modelica.SIunits.MassFlowRate m_flow_nominal_air=31
  "Nominal mass flow rate for air system";

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
      Buildings.Fluid.Sensors.VolumeFlowRate senVolFloDH(redeclare package
        Medium =
            Water, m_flow_nominal=m_flow_nominal) annotation (Placement(
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
      Buildings.Fluid.Sensors.VolumeFlowRate senVolFloSu(redeclare package
        Medium =
            Water, m_flow_nominal=m_flow_nominal) annotation (Placement(
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

  model Infiltration "Constant infiltration"
      replaceable package Air = Buildings.Media.Air(extraPropertiesNames={"CO2"});
      parameter Modelica.SIunits.Volume Vi "Indoor air volume";
      parameter Real ach=0.33 "Infiltration air changes per hour";
      Buildings.Fluid.Sources.MassFlowSource_WeatherData infiltr(
        redeclare package Medium = Air,
        nPorts=1,
        m_flow=ach*Vi/1.2/3600,
      use_C_in=true)
                  "Infiltration"
        annotation (Placement(transformation(extent={{-46,50},{-26,70}})));
      Buildings.Fluid.Sensors.VolumeFlowRate senVolFloIn(redeclare package
        Medium =
            Air, m_flow_nominal=1) annotation (Placement(transformation(
            extent={{10,10},{-10,-10}},
            rotation=180,
            origin={30,60})));
      Buildings.Fluid.Sensors.VolumeFlowRate senVolFloOut(redeclare package
        Medium =
            Air, m_flow_nominal=1) annotation (Placement(transformation(
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
    Buildings.Fluid.Sources.Outside
                          freshAir(nPorts=1, redeclare package Medium = Air)
      "Boundary condition"
      annotation (Placement(transformation(extent={{-40,-70},{-20,-50}})));
    Modelica.Blocks.Sources.Constant cCO2(k=0.00064)
      annotation (Placement(transformation(extent={{-26,8},{-46,28}})));
  equation
      connect(senVolFloOut.port_a, port_b)
        annotation (Line(points={{40,-60},{100,-60}}, color={0,127,255}));
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
    connect(senVolFloOut.port_b, freshAir.ports[1])
      annotation (Line(points={{20,-60},{-20,-60}}, color={0,127,255}));
    connect(freshAir.weaBus, weaBus) annotation (Line(
        points={{-40,-59.8},{-72,-59.8},{-72,60},{-100,60}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(cCO2.y, infiltr.C_in[1]) annotation (Line(points={{-47,18},{-62,18},
            {-62,52},{-46,52}}, color={0,0,127}));
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
                                                          redeclare package
        Medium =
            Air,
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
                                                          redeclare package
        Medium =
            Air,
        m_flow_nominal=m_flow_nominal,
      allowFlowReversal=true)
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
        redeclare Data.AhuFanx4 per,
      allowFlowReversal=true)
        annotation (Placement(transformation(extent={{20,30},{0,50}})));
      Buildings.Fluid.Sensors.TemperatureTwoPort senTemEx2(
                                                          redeclare package
        Medium =
            Air,
        allowFlowReversal=false,
        m_flow_nominal=m_flow_nominal)
        annotation (Placement(transformation(extent={{-80,30},{-100,50}})));
      Buildings.Fluid.Sensors.TemperatureTwoPort senTemIn1(
                                                          redeclare package
        Medium =
            Air,
        m_flow_nominal=m_flow_nominal,
        allowFlowReversal=true)
        annotation (Placement(transformation(extent={{-100,-50},{-80,-30}})));
      Buildings.Fluid.Sensors.TemperatureTwoPort senTemIn3(
                                                          redeclare package
        Medium =
            Air,
        m_flow_nominal=m_flow_nominal,
      allowFlowReversal=true)
        annotation (Placement(transformation(extent={{98,-50},{118,-30}})));
      Modelica.Fluid.Interfaces.FluidPort_b port_b1(redeclare package Medium = Air)
        annotation (Placement(transformation(extent={{150,-50},{170,-30}})));
      Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare package Medium = Air)
        annotation (Placement(transformation(extent={{150,30},{170,50}})));
      Modelica.Blocks.Interfaces.RealInput y annotation (Placement(transformation(
            extent={{-20,-20},{20,20}},
            rotation=-90,
            origin={-60,110})));
      replaceable package Air = Buildings.Media.Air(extraPropertiesNames={"CO2"}) constrainedby
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
            Air,
      use_C_in=true)
        annotation (Placement(transformation(extent={{-140,30},{-120,50}})));
      Buildings.Fluid.Sources.Outside outSu(nPorts=1, redeclare package Medium =
            Air,
      use_C_in=true)
        annotation (Placement(transformation(extent={{-140,-50},{-120,-30}})));
      Buildings.BoundaryConditions.WeatherData.Bus weaBus annotation (Placement(
            transformation(extent={{-180,-22},{-140,18}}), iconTransformation(
              extent={{-200,104},{-180,124}})));
      Buildings.Fluid.HeatExchangers.ConstantEffectiveness hex1(redeclare
        package Medium1 =
                    Air,
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
    Modelica.Blocks.Sources.Constant cCO2(k=0.00064)
      annotation (Placement(transformation(extent={{-98,-10},{-118,10}})));
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
    connect(cCO2.y, outEx.C_in[1]) annotation (Line(points={{-119,0},{-146,0},{-146,
            32},{-142,32}}, color={0,0,127}));
    connect(cCO2.y, outSu.C_in[1]) annotation (Line(points={{-119,0},{-146,0},{-146,
            -48},{-142,-48}}, color={0,0,127}));
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

  model EnergyMeter
      replaceable package Water = Buildings.Media.Water;
      Buildings.Fluid.Sensors.TemperatureTwoPort senTemRe(m_flow_nominal=
            m_flow_nominal, redeclare package Medium = Water)
        annotation (Placement(transformation(extent={{-60,50},{-80,70}})));
      Buildings.Fluid.Sensors.TemperatureTwoPort senTemSu(redeclare package
        Medium =   Water, m_flow_nominal=m_flow_nominal)
        annotation (Placement(transformation(extent={{-80,-70},{-60,-50}})));
      Buildings.Fluid.Sensors.MassFlowRate senMasFloSu(redeclare package Medium =
            Water)
        annotation (Placement(transformation(extent={{40,-70},{60,-50}})));
      Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
            Water) "Supply fluid inlet port"
        annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
      Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
            Water) "Supply fluid outlet port"
        annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
      Modelica.Fluid.Interfaces.FluidPort_a port_a2(redeclare package Medium =
            Water) "Return fluid inlet port"
        annotation (Placement(transformation(extent={{90,50},{110,70}})));
      Modelica.Fluid.Interfaces.FluidPort_b port_b2(redeclare package Medium =
            Water) "Return fluid outlet port"
        annotation (Placement(transformation(extent={{-110,50},{-90,70}})));
      parameter Modelica.SIunits.MassFlowRate m_flow_nominal=0.1
        "Nominal mass flow rate, used for regularization near zero flow";
      Modelica.Blocks.Math.Add add(k1=-1, k2=1)
        annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
      Modelica.Blocks.Sources.RealExpression realExpression(y=Water.cp_const)
        annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
      Modelica.Blocks.Math.MultiProduct multiProduct(nu=3)
        annotation (Placement(transformation(extent={{10,-6},{22,6}})));
      Modelica.Blocks.Interfaces.RealOutput q
        "Heat flow [W] (positive for supply fluid hotter than return)"
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={0,106})));
  equation
      connect(port_a, senTemSu.port_a)
        annotation (Line(points={{-100,-60},{-80,-60}}, color={0,127,255}));
      connect(senTemSu.port_b, senMasFloSu.port_a)
        annotation (Line(points={{-60,-60},{40,-60}}, color={0,127,255}));
      connect(senMasFloSu.port_b, port_b)
        annotation (Line(points={{60,-60},{100,-60}}, color={0,127,255}));
      connect(senTemRe.port_a, port_a2)
        annotation (Line(points={{-60,60},{100,60}}, color={0,127,255}));
      connect(senTemRe.port_b, port_b2)
        annotation (Line(points={{-80,60},{-100,60}}, color={0,127,255}));
      connect(senTemRe.T, add.u1) annotation (Line(points={{-70,71},{-48,71},{-48,
              6},{-42,6}}, color={0,0,127}));
      connect(senTemSu.T, add.u2)
        annotation (Line(points={{-70,-49},{-70,-6},{-42,-6}}, color={0,0,127}));
      connect(realExpression.y, multiProduct.u[1]) annotation (Line(points={{-19,
              30},{-4,30},{-4,2.8},{10,2.8}}, color={0,0,127}));
      connect(add.y, multiProduct.u[2]) annotation (Line(points={{-19,0},{6,0},{6,
              2.22045e-16},{10,2.22045e-16}}, color={0,0,127}));
      connect(senMasFloSu.m_flow, multiProduct.u[3]) annotation (Line(points={{50,
              -49},{-4,-49},{-4,-2.8},{10,-2.8}}, color={0,0,127}));
      connect(multiProduct.y, q) annotation (Line(points={{23.02,0},{40,0},{40,80},
              {0,80},{0,106}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-90,-60},{90,-60}},
              color={238,46,47},
              thickness=0.5),
            Line(
              points={{90,60},{-90,60}},
              color={28,108,200},
              thickness=0.5),
            Line(points={{0,-60},{0,96}}, color={0,0,0}),
            Ellipse(
              extent={{-20,20},{20,-20}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{10,10},{-10,-12}}, color={0,0,0}),
            Line(points={{10,10},{8,4}}, color={0,0,0}),
            Line(points={{10,10},{4,8}}, color={0,0,0})}),           Diagram(
            coordinateSystem(preserveAspectRatio=false)));
  end EnergyMeter;

AirHandlingUnit airHandlingUnit(redeclare package Air = Air,
  m_flow_nominal=m_flow_nominal_air,
  m2_flow_nominal=m_flow_nominal_water,
  redeclare package Water = Water)
  annotation (Placement(transformation(extent={{-152,34},{-120,54}})));
Buildings.ThermalZones.Detailed.MixedAir ou44Bdg(
  nConPar=0,
  nSurBou=0,
  linearizeRadiation=false,
  nConBou=2,
  datConBou(
    layers={floor,extWall},
    A={87*29,3.97*87*2 + 3.97*29*2},
    til={Buildings.Types.Tilt.Floor,Buildings.Types.Tilt.Wall},
    each azi=Buildings.Types.Azimuth.S,
    each stateAtSurface_a=false),
  datConExt(
    layers={roof},
    A={87*29},
    til={Buildings.Types.Tilt.Ceiling},
    azi={Buildings.Types.Azimuth.W}),
  nConExt=1,
  nConExtWin=4,
  redeclare package Medium = Air,
  AFlo=AFlo,
  hRoo=hRoo,
  datConExtWin(
    each layers=extWall,
    A={29*13,87*13,29*13,87*13},
    each glaSys=glaSys,
    hWin={11.9,2.4*3,11.9,2.4*3},
    wWin={16.8,70,16.8,70},
    each til=Buildings.Types.Tilt.Wall,
    azi={Buildings.Types.Azimuth.N,Buildings.Types.Azimuth.W,Buildings.Types.Azimuth.S,
        Buildings.Types.Azimuth.E}),
    use_C_flow=true,
    nPorts=5,
    lat=0.96697872811643,
    C_start={0.00064})
  annotation (Placement(transformation(extent={{-18,36},{22,76}})));
final parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Insulation100Concrete200
  roof(material={insulationRoof,concreteRoof})
       annotation (Placement(transformation(extent={{176,192},{196,212}})));
final parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Concrete200 floor(material=
      {insulationFloor,concreteFloor})
  annotation (Placement(transformation(extent={{148,166},{168,186}})));
final parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Brick120 intWall(material=
      {lightPartition})
  annotation (Placement(transformation(extent={{176,166},{196,186}})));
final parameter Buildings.HeatTransfer.Data.GlazingSystems.TripleClearAir13ClearAir13Clear
  glaSys(haveExteriorShade=true, shade=blinds)
         annotation (Placement(transformation(extent={{204,166},{224,186}})));
final parameter Buildings.HeatTransfer.Data.Solids.Generic insulation(
  x=0.27,
  k=0.04,
  c=1000,
  d=50)
  annotation (Placement(transformation(extent={{92,166},{112,186}})));
final parameter Buildings.HeatTransfer.Data.Solids.Concrete concrete(x=0.2)
  annotation (Placement(transformation(extent={{120,166},{140,186}})));
final parameter Buildings.HeatTransfer.Data.Solids.Generic lightPartition(
  c=1000,
  k=0.5,
  x=0.15,
  d=250)
  annotation (Placement(transformation(extent={{64,166},{84,186}})));
final parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic extWall(
  nLay=2,
  material={insulation,concrete},
  roughness_a=Buildings.HeatTransfer.Types.SurfaceRoughness.Medium)
  annotation (Placement(transformation(extent={{148,192},{168,212}})));
final parameter Buildings.HeatTransfer.Data.Solids.Generic insulationRoof(
  k=0.04,
  c=1000,
  x=0.52,
  d=50)
  annotation (Placement(transformation(extent={{92,192},{112,212}})));
final parameter Buildings.HeatTransfer.Data.Solids.Concrete concreteRoof(x=0.27)
  annotation (Placement(transformation(extent={{120,192},{140,212}})));
final parameter Buildings.HeatTransfer.Data.Solids.Concrete concreteFloor(x=0.2)
  annotation (Placement(transformation(extent={{64,192},{84,212}})));
final parameter Buildings.HeatTransfer.Data.Shades.Generic blinds(
  tauSol_a=0.05,
  tauSol_b=0.05,
  rhoSol_a=0.5,
  rhoSol_b=0.5,
  absIR_a=0.5,
  absIR_b=0.5,
  tauIR_a=0,
  tauIR_b=0)
  annotation (Placement(transformation(extent={{204,192},{224,212}})));
Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=
        ModelicaServices.ExternalReferences.loadResource("modelica://OU44Emulator/Resources/Climate/DNK_Copenhagen.061800_IWEC.mos"))
  annotation (Placement(transformation(extent={{110,80},{90,100}})));
Buildings.BoundaryConditions.WeatherData.Bus weaBus annotation (Placement(
      transformation(extent={{18,70},{58,110}}),iconTransformation(extent={{-160,
          110},{-140,130}})));
Modelica.Blocks.Math.MatrixGain matrixGain(K=[0.4; 0.4; 0.2])
  "Splits heat gains into radiant, convective and latent"
  annotation (Placement(transformation(extent={{-70,132},{-50,152}})));
Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature tFloorGround
  annotation (Placement(transformation(extent={{40,8},{20,28}})));
Modelica.Blocks.Sources.Constant const5(k=283.15)
  annotation (Placement(transformation(extent={{72,8},{52,28}})));
Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature tWallGround
  annotation (Placement(transformation(extent={{40,-28},{20,-8}})));
Modelica.Blocks.Sources.Constant const4(k=283.15)
  annotation (Placement(transformation(extent={{72,-28},{52,-8}})));
Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor Ti
  annotation (Placement(transformation(extent={{34,46},{54,66}})));
DistrictHeating districtHeating(m_flow_nominal=5)
  annotation (Placement(transformation(extent={{-142,-212},{-122,-192}})));
Buildings.Fluid.HeatExchangers.Radiators.RadiatorEN442_2 rad(
  redeclare package Medium = Water,
  Q_flow_nominal=30*AFlo,
  T_a_nominal=328.15,
  T_b_nominal=318.15)
  annotation (Placement(transformation(extent={{-14,-92},{6,-72}})));
Buildings.Fluid.Storage.ExpansionVessel exp(redeclare package Medium = Water,
    V_start=0.025)
  annotation (Placement(transformation(extent={{20,-82},{40,-62}})));
Buildings.Fluid.Actuators.Valves.ThreeWayLinear valRad(
  redeclare package Medium = Water,
  CvData=Buildings.Fluid.Types.CvTypes.OpPoint,
  dpValve_nominal=5,
  m_flow_nominal=m_flow_nominal_water)
  annotation (Placement(transformation(extent={{-70,-92},{-50,-72}})));
Buildings.Fluid.Sensors.TemperatureTwoPort tRadIn(redeclare package Medium =
      Water, m_flow_nominal=m_flow_nominal_water)
  annotation (Placement(transformation(extent={{-40,-92},{-20,-72}})));
Buildings.Fluid.Sensors.TemperatureTwoPort tRadOut(redeclare package Medium =
      Water, m_flow_nominal=m_flow_nominal_water)
  annotation (Placement(transformation(extent={{-20,-132},{-40,-112}})));
Infiltration infiltration(
  redeclare package Air = Air,
  Vi=AFlo*hRoo,
    ach=0.33)
            annotation (Placement(transformation(extent={{-80,6},{-60,26}})));
Buildings.Fluid.FixedResistances.Junction jun1(
  redeclare package Medium = Water,
  portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
  portFlowDirection_2=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
  portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
  m_flow_nominal={m_flow_nominal_water,-m_flow_nominal_water,
      m_flow_nominal_water},
  dp_nominal={5,0,5})
  annotation (Placement(transformation(
      extent={{10,10},{-10,-10}},
      rotation=0,
      origin={-60,-122})));
Buildings.Fluid.FixedResistances.Junction jun2(
  redeclare package Medium = Water,
  portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
  portFlowDirection_2=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
  portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
  m_flow_nominal={m_flow_nominal_water,-m_flow_nominal_water,-
      m_flow_nominal_water},
  dp_nominal={5,0,5}) annotation (Placement(transformation(
      extent={{10,10},{-10,-10}},
      rotation=-90,
      origin={-126,-82})));
Buildings.Fluid.FixedResistances.Junction jun3(
  redeclare package Medium = Water,
  dp_nominal={5,0,5},
  portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
  portFlowDirection_2=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
  portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
  m_flow_nominal={m_flow_nominal_water,-m_flow_nominal_water,
      m_flow_nominal_water})
  annotation (Placement(transformation(
      extent={{-10,10},{10,-10}},
      rotation=-90,
      origin={-152,-108})));
EnergyMeter energyMeterAhu(m_flow_nominal=m_flow_nominal_water, redeclare
      package Water=Water) annotation (Placement(transformation(
      extent={{-10,-10},{10,10}},
      rotation=90,
      origin={-132,-44})));
EnergyMeter energyMeterRad(m_flow_nominal=m_flow_nominal_water, redeclare
      package Water=Water) annotation (Placement(transformation(
      extent={{-10,10},{10,-10}},
      rotation=0,
      origin={-94,-102})));
EnergyMeter energyMeterMain(m_flow_nominal=m_flow_nominal_water, redeclare
      package Water=Water)  annotation (Placement(transformation(
      extent={{-10,-10},{10,10}},
      rotation=90,
      origin={-132,-170})));
Buildings.Fluid.Actuators.Valves.ThreeWayLinear valRad1(
  redeclare package Medium = Water,
  CvData=Buildings.Fluid.Types.CvTypes.OpPoint,
  dpValve_nominal=5,
  m_flow_nominal=m_flow_nominal_water)
                     annotation (Placement(transformation(
      extent={{10,-10},{-10,10}},
      rotation=270,
      origin={-126,-8})));
Buildings.Fluid.FixedResistances.Junction jun4(
  redeclare package Medium = Water,
  dp_nominal={5,0,5},
  portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
  portFlowDirection_2=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
  portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
  m_flow_nominal={m_flow_nominal_water,-m_flow_nominal_water,
      m_flow_nominal_water})
  annotation (Placement(transformation(
      extent={{-10,10},{10,-10}},
      rotation=-90,
      origin={-152,-8})));
Buildings.Fluid.FixedResistances.PressureDrop res(
  redeclare package Medium = Water,
  m_flow_nominal=m_flow_nominal_water,
  dp_nominal=25000) "Used to offset the circulation pump work range"
  annotation (Placement(transformation(
      extent={{-10,-10},{10,10}},
      rotation=90,
      origin={-126,-136})));
Modelica.Blocks.Math.Gain metHeat(k=120/AFlo)
  "Metabolic heat generation per person (sensible and latent)"
  annotation (Placement(transformation(extent={{-108,132},{-88,152}})));
final parameter Buildings.HeatTransfer.Data.Solids.Generic insulationFloor(
  k=0.04,
  c=1000,
  x=0.15,
  d=50) annotation (Placement(transformation(extent={{36,192},{56,212}})));
  Modelica.Blocks.Math.Gain gaiCO2(k=8.18E-6) "CO2 emission per person"
    annotation (Placement(transformation(extent={{-108,98},{-88,118}})));
  Modelica.Blocks.Math.Gain maxOcc(k=1350)
    annotation (Placement(transformation(extent={{-158,114},{-138,134}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(T=3600)
    annotation (Placement(transformation(extent={{-196,114},{-176,134}})));
  Buildings.Fluid.Sensors.PPM senCO2(redeclare package Medium = Air)
    annotation (Placement(transformation(extent={{-46,54},{-66,74}})));
  Modelica.Blocks.Sources.Pulse pulse(
    startTime=3600*7,
    width=33,
    period=3600*24,
    amplitude=1)
    annotation (Placement(transformation(extent={{-228,114},{-208,134}})));
equation
connect(weaBus, ou44Bdg.weaBus) annotation (Line(
    points={{38,90},{38,73.9},{19.9,73.9}},
    color={255,204,51},
    thickness=0.5), Text(
    string="%first",
    index=-1,
    extent={{-6,3},{-6,3}}));
connect(matrixGain.y, ou44Bdg.qGai_flow) annotation (Line(points={{-49,142},{-36,
          142},{-36,64},{-19.6,64}},
                                   color={0,0,127}));
connect(weaBus, weaDat.weaBus) annotation (Line(
    points={{38,90},{90,90}},
    color={255,204,51},
    thickness=0.5), Text(
    string="%first",
    index=-1,
    extent={{-6,3},{-6,3}}));
connect(tFloorGround.port, ou44Bdg.surf_conBou[1])
  annotation (Line(points={{20,18},{8,18},{8,39.5}},      color={191,0,0}));
connect(const5.y, tFloorGround.T)
  annotation (Line(points={{51,18},{42,18}},     color={0,0,127}));
connect(const4.y, tWallGround.T)
  annotation (Line(points={{51,-18},{42,-18}},     color={0,0,127}));
connect(tWallGround.port, ou44Bdg.surf_conBou[2]) annotation (Line(points={{20,-18},
        {8,-18},{8,40.5}},              color={191,0,0}));
connect(Ti.port, ou44Bdg.heaPorAir) annotation (Line(points={{34,56},{1,56}},
                            color={191,0,0}));
connect(rad.heatPortRad, ou44Bdg.heaPorRad) annotation (Line(points={{-2,-74.8},
        {-2,-60},{2,-60},{2,52.2},{1,52.2}}, color={191,0,0}));
connect(rad.heatPortCon, ou44Bdg.heaPorAir)
  annotation (Line(points={{-6,-74.8},{-6,56},{1,56}}, color={191,0,0}));
connect(rad.port_b, exp.port_a)
  annotation (Line(points={{6,-82},{30,-82}}, color={0,127,255}));
connect(valRad.port_2, tRadIn.port_a)
  annotation (Line(points={{-50,-82},{-40,-82}}, color={0,127,255}));
connect(tRadIn.port_b, rad.port_a)
  annotation (Line(points={{-20,-82},{-14,-82}}, color={0,127,255}));
connect(exp.port_a, tRadOut.port_a) annotation (Line(points={{30,-82},{30,-122},
        {-20,-122}},       color={0,127,255}));
connect(weaBus, infiltration.weaBus) annotation (Line(
    points={{38,90},{-162,90},{-162,22},{-81.6,22}},
    color={255,204,51},
    thickness=0.5), Text(
    string="%first",
    index=-1,
    extent={{-6,3},{-6,3}}));
connect(airHandlingUnit.weaBus, weaBus) annotation (Line(
    points={{-155,55.4},{-162,55.4},{-162,90},{38,90}},
    color={255,204,51},
    thickness=0.5), Text(
    string="%second",
    index=1,
    extent={{6,3},{6,3}}));
connect(jun1.port_3, valRad.port_3)
  annotation (Line(points={{-60,-112},{-60,-92}}, color={0,127,255}));
connect(jun1.port_1, tRadOut.port_b)
  annotation (Line(points={{-50,-122},{-40,-122}}, color={0,127,255}));
connect(jun2.port_2, energyMeterAhu.port_a)
  annotation (Line(points={{-126,-72},{-126,-54}}, color={0,127,255}));
connect(energyMeterAhu.port_b2, jun3.port_1) annotation (Line(points={{-138,-54},
        {-138,-64},{-152,-64},{-152,-98}}, color={0,127,255}));
connect(jun2.port_3, energyMeterRad.port_a) annotation (Line(points={{-116,-82},
        {-110,-82},{-110,-96},{-104,-96}}, color={0,127,255}));
connect(valRad.port_1, energyMeterRad.port_b) annotation (Line(points={{-70,-82},
        {-76,-82},{-76,-96},{-84,-96}}, color={0,127,255}));
connect(jun1.port_2, energyMeterRad.port_a2) annotation (Line(points={{-70,-122},
        {-76,-122},{-76,-108},{-84,-108}}, color={0,127,255}));
connect(energyMeterRad.port_b2, jun3.port_3)
  annotation (Line(points={{-104,-108},{-142,-108}}, color={0,127,255}));
connect(districtHeating.port_b, energyMeterMain.port_a)
  annotation (Line(points={{-126,-192},{-126,-180}}, color={0,127,255}));
connect(jun3.port_2, energyMeterMain.port_a2) annotation (Line(points={{-152,-118},
        {-152,-124},{-138,-124},{-138,-160}}, color={0,127,255}));
connect(energyMeterMain.port_b2, districtHeating.port_a)
  annotation (Line(points={{-138,-180},{-138,-192}}, color={0,127,255}));
connect(energyMeterAhu.port_b, valRad1.port_1)
  annotation (Line(points={{-126,-34},{-126,-18}}, color={0,127,255}));
connect(valRad1.port_3, jun4.port_3)
  annotation (Line(points={{-136,-8},{-142,-8}}, color={0,127,255}));
connect(airHandlingUnit.port_b2, jun4.port_1) annotation (Line(points={{-132,34},
        {-132,28},{-152,28},{-152,2}}, color={0,127,255}));
connect(jun4.port_2, energyMeterAhu.port_a2) annotation (Line(points={{-152,-18},
        {-152,-26},{-138,-26},{-138,-34}}, color={0,127,255}));
connect(airHandlingUnit.port_a2, valRad1.port_2)
  annotation (Line(points={{-126,34},{-126,2}}, color={0,127,255}));
connect(energyMeterMain.port_b, res.port_a)
  annotation (Line(points={{-126,-160},{-126,-146}}, color={0,127,255}));
connect(jun2.port_1, res.port_b)
  annotation (Line(points={{-126,-92},{-126,-126}}, color={0,127,255}));
connect(matrixGain.u[1], metHeat.y)
  annotation (Line(points={{-72,142},{-87,142}}, color={0,0,127}));
  connect(gaiCO2.y, ou44Bdg.C_flow[1]) annotation (Line(points={{-87,108},{-42,108},
          {-42,58.8},{-19.6,58.8}}, color={0,0,127}));
  connect(maxOcc.y, metHeat.u) annotation (Line(points={{-137,124},{-124,124},{-124,
          142},{-110,142}}, color={0,0,127}));
  connect(maxOcc.y, gaiCO2.u) annotation (Line(points={{-137,124},{-124,124},{-124,
          108},{-110,108}}, color={0,0,127}));
  connect(maxOcc.u, firstOrder.y)
    annotation (Line(points={{-160,124},{-175,124}}, color={0,0,127}));
  connect(infiltration.port_b, ou44Bdg.ports[1]) annotation (Line(points={{-60,10},
          {-44,10},{-44,42.8},{-13,42.8}}, color={0,127,255}));
  connect(infiltration.port_a, ou44Bdg.ports[2]) annotation (Line(points={{-60,22},
          {-46,22},{-46,44.4},{-13,44.4}}, color={0,127,255}));
  connect(airHandlingUnit.port_b1, ou44Bdg.ports[3]) annotation (Line(points={{-120,
          40},{-66,40},{-66,46},{-13,46}}, color={0,127,255}));
  connect(airHandlingUnit.port_a1, ou44Bdg.ports[4]) annotation (Line(points={{-120,
          48},{-66,48},{-66,47.6},{-13,47.6}}, color={0,127,255}));
  connect(senCO2.port, ou44Bdg.ports[5]) annotation (Line(points={{-56,54},{-56,
          49.2},{-13,49.2}}, color={0,127,255}));
  connect(pulse.y, firstOrder.u)
    annotation (Line(points={{-207,124},{-198,124}}, color={0,0,127}));
annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-240,
          -220},{240,220}}), graphics={Bitmap(
        extent={{-160,-162},{178,180}}, fileName="ou44.jpg")}),Diagram(
      coordinateSystem(preserveAspectRatio=false, extent={{-240,-220},{240,
          220}})),
  experiment(StopTime=259200));
end BuildingBase;
