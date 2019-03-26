within OU44Emulator.Models;
model BuildingControl
  extends BuildingBase;
  Buildings.Controls.Continuous.LimPID conPIDcoil(
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
    annotation (Placement(transformation(extent={{-70,172},{-50,192}})));
  Modelica.Blocks.Sources.Constant shades(k=0)
    annotation (Placement(transformation(extent={{-168,172},{-148,192}})));
  Modelica.Blocks.Sources.Constant pump(k=1)
    annotation (Placement(transformation(extent={{-178,-206},{-158,-186}})));
  Modelica.Blocks.Sources.Constant stpCO2(k=800) "CO2 setpoint [ppm]"
    annotation (Placement(transformation(extent={{-230,72},{-210,92}})));
  Buildings.Controls.Continuous.LimPID conPIDfan(
    k=0.2,
    Ti=600,
    controllerType=Modelica.Blocks.Types.SimpleController.P,
    reverseAction=true)
    annotation (Placement(transformation(extent={{-194,72},{-174,92}})));
equation
  connect(conPIDcoil.y, valRad1.y) annotation (Line(points={{-89,-20},{-101.5,-20},
          {-101.5,-8},{-114,-8}}, color={0,0,127}));
  connect(conPIDcoil.u_s, veAirSp.y)
    annotation (Line(points={{-66,-20},{-51,-20}}, color={0,0,127}));
  connect(conPIDrad.y, valRad.y) annotation (Line(points={{53,-58},{-60,-58},
          {-60,-70}}, color={0,0,127}));
  connect(Ti.T, conPIDrad.u_m) annotation (Line(points={{54,56},{86,56},{86,
          -84},{64,-84},{64,-70}}, color={0,0,127}));
  connect(airHandlingUnit.Tsu, conPIDcoil.u_m) annotation (Line(points={{-119.4,
          36},{-96,36},{-96,-38},{-78,-38},{-78,-32}}, color={0,0,127}));
  connect(inAirSp.y, conPIDrad.u_s) annotation (Line(points={{93,-58},{84,-58},
          {84,-58},{76,-58}}, color={0,0,127}));
  connect(matrixGain1.y, ou44Bdg.uSha) annotation (Line(points={{-49,182},{-28,182},
          {-28,74},{-19.6,74}},          color={0,0,127}));
  connect(shades.y, matrixGain1.u[1])
    annotation (Line(points={{-147,182},{-72,182}}, color={0,0,127}));
  connect(districtHeating.y, pump.y)
    annotation (Line(points={{-143,-196},{-157,-196}}, color={0,0,127}));
  connect(senCO2.ppm,conPIDfan. u_m)
    annotation (Line(points={{-67,64},{-184,64},{-184,70}}, color={0,0,127}));
  connect(stpCO2.y,conPIDfan. u_s)
    annotation (Line(points={{-209,82},{-196,82}}, color={0,0,127}));
  connect(conPIDfan.y, airHandlingUnit.y)
    annotation (Line(points={{-173,82},{-142,82},{-142,55}}, color={0,0,127}));
  annotation (
    experiment(StopTime=86400, __Dymola_NumberOfIntervals=100),
    __Dymola_experimentSetupOutput,
    __Dymola_experimentFlags(
      Advanced(GenerateVariableDependencies=false, OutputModelicaCode=false),
      Evaluate=false,
      OutputCPUtime=false,
      OutputFlatModelica=false));
end BuildingControl;
