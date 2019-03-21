within OU44Emulator.SingleZone.Validation;
model BuildingConstInput
  BuildingIO buildingIO
    annotation (Placement(transformation(extent={{-26,-22},{22,22}})));
  Modelica.Blocks.Sources.Constant shades(k=0)
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  Modelica.Blocks.Sources.Constant occupants(k=0)
    annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
  Modelica.Blocks.Sources.Constant fans(k=1)
    annotation (Placement(transformation(extent={{-80,-30},{-60,-10}})));
  Modelica.Blocks.Sources.Constant valveAHU(k=1)
    annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
  Modelica.Blocks.Sources.Constant valveRad(k=1)
    annotation (Placement(transformation(extent={{-80,-92},{-60,-72}})));
  Modelica.Blocks.Sources.Constant pump(k=1)
    annotation (Placement(transformation(extent={{0,-60},{-20,-40}})));
equation
  connect(shades.y, buildingIO.shaN) annotation (Line(points={{-59,50},{-44,
          50},{-44,20},{-26.6,20}}, color={0,0,127}));
  connect(shades.y, buildingIO.shaW) annotation (Line(points={{-59,50},{-44,
          50},{-44,17},{-26.6,17}}, color={0,0,127}));
  connect(shades.y, buildingIO.shaS) annotation (Line(points={{-59,50},{-44,
          50},{-44,14.2},{-26.6,14.2}}, color={0,0,127}));
  connect(shades.y, buildingIO.shaE) annotation (Line(points={{-59,50},{-44,
          50},{-44,11.4},{-26.6,11.4}}, color={0,0,127}));
  connect(occupants.y, buildingIO.noc) annotation (Line(points={{-59,10},{
          -44,10},{-44,8},{-26.6,8}}, color={0,0,127}));
  connect(fans.y, buildingIO.fan) annotation (Line(points={{-59,-20},{-44,
          -20},{-44,4.8},{-26.6,4.8}}, color={0,0,127}));
  connect(valveAHU.y, buildingIO.vAHU) annotation (Line(points={{-59,-50},{
          -42,-50},{-42,1},{-26.6,1}}, color={0,0,127}));
  connect(valveRad.y, buildingIO.vRad) annotation (Line(points={{-59,-82},{
          -40,-82},{-40,-6},{-26.6,-6}}, color={0,0,127}));
  connect(pump.y, buildingIO.pmp) annotation (Line(points={{-21,-50},{-38,
          -50},{-38,-19.6},{-26.6,-19.6}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end BuildingConstInput;
