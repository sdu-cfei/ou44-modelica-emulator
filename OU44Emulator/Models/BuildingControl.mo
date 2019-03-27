within OU44Emulator.Models;
model BuildingControl
  extends BuildingBase;
  Buildings.Controls.Continuous.LimPID conPIDcoil(
    Ti=600,
    k=1,
    controllerType=Modelica.Blocks.Types.SimpleController.P)
    annotation (Placement(transformation(extent={{-66,-18},{-86,2}})));
  Modelica.Blocks.Sources.Constant veAirSp(k=294.15)
    annotation (Placement(transformation(extent={{-30,-18},{-50,2}})));
  Buildings.Controls.Continuous.LimPID conPIDrad(
    Ti=600,
    controllerType=Modelica.Blocks.Types.SimpleController.PD,
    Td=120,
    k=1,
    initType=Modelica.Blocks.Types.InitPID.InitialState,
    xd_start=0)
    annotation (Placement(transformation(extent={{136,-60},{116,-40}})));
  Modelica.Blocks.Sources.Constant inAirSp(k=294.15)
    annotation (Placement(transformation(extent={{176,-60},{156,-40}})));
  Modelica.Blocks.Math.MatrixGain splitFour(K=[1; 1; 1; 1])
    "Splits signal into four elevations"
    annotation (Placement(transformation(extent={{-70,172},{-50,192}})));
  Modelica.Blocks.Sources.Constant shades(k=0)
    annotation (Placement(transformation(extent={{-120,172},{-100,192}})));
  Modelica.Blocks.Sources.Constant pump(k=1)
    annotation (Placement(transformation(extent={{-178,-206},{-158,-186}})));
  Modelica.Blocks.Sources.Constant stpCO2(k=800) "CO2 setpoint [ppm]"
    annotation (Placement(transformation(extent={{-230,72},{-210,92}})));
  Buildings.Controls.Continuous.LimPID conPIDfan(
    reverseAction=true,
    controllerType=Modelica.Blocks.Types.SimpleController.PID,
    Td=300,
    Ti=600,
    k=0.005,
    initType=Modelica.Blocks.Types.InitPID.InitialState,
    xi_start=0,
    xd_start=0)
    annotation (Placement(transformation(extent={{-194,72},{-174,92}})));
equation
  connect(conPIDcoil.y,valCoil.y)  annotation (Line(points={{-87,-8},{-114,-8}},
                                  color={0,0,127}));
  connect(conPIDrad.y, valRad.y) annotation (Line(points={{115,-50},{-58,-50},{
          -58,-70}},  color={0,0,127}));
  connect(Ti.T, conPIDrad.u_m) annotation (Line(points={{54,56},{146,56},{146,
          -70},{126,-70},{126,-62}},
                                   color={0,0,127}));
  connect(airHandlingUnit.Tsu, conPIDcoil.u_m) annotation (Line(points={{-119.4,
          36},{-96,36},{-96,-28},{-76,-28},{-76,-20}}, color={0,0,127}));
  connect(splitFour.y, ou44Bdg.uSha) annotation (Line(points={{-49,182},{-28,
          182},{-28,74},{-19.6,74}}, color={0,0,127}));
  connect(shades.y, splitFour.u[1])
    annotation (Line(points={{-99,182},{-72,182}}, color={0,0,127}));
  connect(districtHeating.y, pump.y)
    annotation (Line(points={{-143,-196},{-157,-196}}, color={0,0,127}));
  connect(senCO2.ppm,conPIDfan. u_m)
    annotation (Line(points={{-67,64},{-184,64},{-184,70}}, color={0,0,127}));
  connect(stpCO2.y,conPIDfan. u_s)
    annotation (Line(points={{-209,82},{-196,82}}, color={0,0,127}));
  connect(conPIDfan.y, airHandlingUnit.y)
    annotation (Line(points={{-173,82},{-142,82},{-142,55}}, color={0,0,127}));
  connect(inAirSp.y, conPIDrad.u_s)
    annotation (Line(points={{155,-50},{138,-50}}, color={0,0,127}));
  connect(veAirSp.y, conPIDcoil.u_s)
    annotation (Line(points={{-51,-8},{-64,-8}}, color={0,0,127}));
  annotation (
    experiment(StopTime=2678400, Interval=600),
    __Dymola_experimentSetupOutput,
    __Dymola_experimentFlags(
      Advanced(GenerateVariableDependencies=false, OutputModelicaCode=false),
      Evaluate=false,
      OutputCPUtime=false,
      OutputFlatModelica=false));
end BuildingControl;
