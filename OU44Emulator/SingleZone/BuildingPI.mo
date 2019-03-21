within OU44Emulator.SingleZone;
model BuildingPI
  extends BuildingBase;
  Buildings.Controls.Continuous.LimPID conPIDve(
    k=0.2,
    Ti=600,
    controllerType=Modelica.Blocks.Types.SimpleController.P)
    annotation (Placement(transformation(extent={{-68,-30},{-88,-10}})));
  Modelica.Blocks.Sources.Constant veAirSp(k=294.15)
    annotation (Placement(transformation(extent={{-30,-30},{-50,-10}})));
  Buildings.Controls.Continuous.LimPID conPIDrad(
    Ti=60,
    k=0.2,
    controllerType=Modelica.Blocks.Types.SimpleController.P)
    annotation (Placement(transformation(extent={{74,-68},{54,-48}})));
  Modelica.Blocks.Sources.Constant inAirSp(k=294.15)
    annotation (Placement(transformation(extent={{114,-68},{94,-48}})));
  Modelica.Blocks.Math.MatrixGain matrixGain1(K=[1; 1; 1; 1])
    "Splits heat gains into radiant, convective and latent"
    annotation (Placement(transformation(extent={{-70,152},{-50,172}})));
  Modelica.Blocks.Sources.Constant people(k=0)
    annotation (Placement(transformation(extent={{-170,110},{-150,130}})));
  Modelica.Blocks.Sources.Constant shades(k=0)
    annotation (Placement(transformation(extent={{-168,152},{-148,172}})));
  Modelica.Blocks.Sources.Constant pump(k=1)
    annotation (Placement(transformation(extent={{-178,-206},{-158,-186}})));
  Modelica.Blocks.Sources.Constant fans(k=1)
    annotation (Placement(transformation(extent={{-212,60},{-192,80}})));
equation
  connect(conPIDve.y, valRad1.y) annotation (Line(points={{-89,-20},{-101.5,
          -20},{-101.5,-8},{-114,-8}}, color={0,0,127}));
  connect(conPIDve.u_s, veAirSp.y)
    annotation (Line(points={{-66,-20},{-51,-20}}, color={0,0,127}));
  connect(conPIDrad.y, valRad.y) annotation (Line(points={{53,-58},{-60,-58},
          {-60,-70}}, color={0,0,127}));
  connect(Ti.T, conPIDrad.u_m) annotation (Line(points={{54,56},{86,56},{86,
          -84},{64,-84},{64,-70}}, color={0,0,127}));
  connect(airHandlingUnit.Tsu, conPIDve.u_m) annotation (Line(points={{-119.4,
          36},{-96,36},{-96,-38},{-78,-38},{-78,-32}}, color={0,0,127}));
  connect(inAirSp.y, conPIDrad.u_s) annotation (Line(points={{93,-58},{84,-58},
          {84,-58},{76,-58}}, color={0,0,127}));
  connect(matrixGain1.y, ou44Bdg.uSha) annotation (Line(points={{-49,162},{
          -28,162},{-28,74},{-19.6,74}}, color={0,0,127}));
  connect(people.y, metHeat.u) annotation (Line(points={{-149,120},{-130,120},
          {-130,120},{-110,120}}, color={0,0,127}));
  connect(shades.y, matrixGain1.u[1])
    annotation (Line(points={{-147,162},{-72,162}}, color={0,0,127}));
  connect(districtHeating.y, pump.y)
    annotation (Line(points={{-143,-196},{-157,-196}}, color={0,0,127}));
  connect(fans.y, airHandlingUnit.y) annotation (Line(points={{-191,70},{-142,
          70},{-142,55}}, color={0,0,127}));
  annotation (
    experiment(StopTime=8640000, __Dymola_NumberOfIntervals=2000),
    __Dymola_experimentSetupOutput,
    __Dymola_experimentFlags(
      Advanced(GenerateVariableDependencies=false, OutputModelicaCode=false),
      Evaluate=false,
      OutputCPUtime=false,
      OutputFlatModelica=false));
end BuildingPI;
