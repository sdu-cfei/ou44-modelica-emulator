within OU44Emulator.SingleZone;
model BuildingIO
  extends BuildingBase;
  Modelica.Blocks.Interfaces.RealInput shaN
    annotation (Placement(transformation(extent={{-266,180},{-226,220}})));
  Modelica.Blocks.Interfaces.RealInput shaW
    annotation (Placement(transformation(extent={{-266,150},{-226,190}})));
  Modelica.Blocks.Interfaces.RealInput shaS
    annotation (Placement(transformation(extent={{-266,122},{-226,162}})));
  Modelica.Blocks.Interfaces.RealInput shaE
    annotation (Placement(transformation(extent={{-266,94},{-226,134}})));
  Modelica.Blocks.Routing.Multiplex4 multiplex4_1
    annotation (Placement(transformation(extent={{-178,146},{-158,166}})));
  Modelica.Blocks.Interfaces.RealInput noc
    annotation (Placement(transformation(extent={{-266,60},{-226,100}})));
  Modelica.Blocks.Interfaces.RealInput vAHU
    annotation (Placement(transformation(extent={{-266,-10},{-226,30}})));
  Modelica.Blocks.Interfaces.RealInput vRad
    annotation (Placement(transformation(extent={{-266,-80},{-226,-40}})));
  Modelica.Blocks.Interfaces.RealInput fan
    annotation (Placement(transformation(extent={{-266,28},{-226,68}})));
  Modelica.Blocks.Interfaces.RealInput pmp
    annotation (Placement(transformation(extent={{-266,-216},{-226,-176}})));
  Modelica.Blocks.Interfaces.RealOutput qelAHU
    annotation (Placement(transformation(extent={{236,50},{256,70}})));
  Modelica.Blocks.Interfaces.RealOutput qelPmp
    annotation (Placement(transformation(extent={{238,-206},{258,-186}})));
  Modelica.Blocks.Interfaces.RealOutput qhAHU
    annotation (Placement(transformation(extent={{236,-66},{256,-46}})));
  Modelica.Blocks.Interfaces.RealOutput qhTot
    annotation (Placement(transformation(extent={{238,-150},{258,-130}})));
  Modelica.Blocks.Interfaces.RealOutput qhRad
    annotation (Placement(transformation(extent={{236,-100},{256,-80}})));
  Modelica.Blocks.Interfaces.RealOutput Tin
    annotation (Placement(transformation(extent={{236,10},{256,30}})));
  Modelica.Blocks.Interfaces.RealOutput Tve
    annotation (Placement(transformation(extent={{236,-30},{256,-10}})));
equation
  connect(shaN, multiplex4_1.u1[1]) annotation (Line(points={{-246,200},{-210,
          200},{-210,165},{-180,165}}, color={0,0,127}));
  connect(shaW, multiplex4_1.u2[1]) annotation (Line(points={{-246,170},{-214,
          170},{-214,159},{-180,159}}, color={0,0,127}));
  connect(shaS, multiplex4_1.u3[1]) annotation (Line(points={{-246,142},{-214,
          142},{-214,153},{-180,153}}, color={0,0,127}));
  connect(shaE, multiplex4_1.u4[1]) annotation (Line(points={{-246,114},{-210,
          114},{-210,147},{-180,147}}, color={0,0,127}));
  connect(multiplex4_1.y, ou44Bdg.uSha) annotation (Line(points={{-157,156},{
          -26,156},{-26,74},{-19.6,74}}, color={0,0,127}));
  connect(noc, metHeat.u) annotation (Line(points={{-246,80},{-199,80},{-199,
          120},{-110,120}}, color={0,0,127}));
  connect(vAHU, valRad1.y) annotation (Line(points={{-246,10},{-104,10},{-104,
          -8},{-114,-8}}, color={0,0,127}));
  connect(vRad, valRad.y) annotation (Line(points={{-246,-60},{-60,-60},{-60,
          -70}}, color={0,0,127}));
  connect(fan, airHandlingUnit.y) annotation (Line(points={{-246,48},{-200,48},
          {-200,70},{-142,70},{-142,55}}, color={0,0,127}));
  connect(pmp, districtHeating.y)
    annotation (Line(points={{-246,-196},{-143,-196}}, color={0,0,127}));
  connect(airHandlingUnit.qel, qelAHU) annotation (Line(points={{-146,33.4},{
          -146,32},{-162,32},{-162,104},{200,104},{200,60},{246,60}}, color={
          0,0,127}));
  connect(districtHeating.qel, qelPmp)
    annotation (Line(points={{-121.4,-196},{248,-196}}, color={0,0,127}));
  connect(energyMeterAhu.q, qhAHU) annotation (Line(points={{-142.6,-44},{
          -152,-44},{-152,-56},{246,-56}}, color={0,0,127}));
  connect(energyMeterMain.q, qhTot) annotation (Line(points={{-142.6,-170},{
          -156,-170},{-156,-152},{80,-152},{80,-140},{248,-140}}, color={0,0,
          127}));
  connect(energyMeterRad.q, qhRad) annotation (Line(points={{-94,-112.6},{-94,
          -130},{60,-130},{60,-90},{246,-90}}, color={0,0,127}));
  connect(Ti.T, Tin) annotation (Line(points={{54,56},{148,56},{148,20},{246,
          20}}, color={0,0,127}));
  connect(Tve, Tve)
    annotation (Line(points={{246,-20},{246,-20}}, color={0,0,127}));
  connect(airHandlingUnit.Tsu, Tve) annotation (Line(points={{-119.4,36},{126,
          36},{126,-20},{246,-20}}, color={0,0,127}));
end BuildingIO;
