within OU44Emulator.SingleZone;
partial model BuildingBase
  "Single-zone whole building model"
  package Water = Buildings.Media.Water;
  package Air = Buildings.Media.Air;
  final parameter Modelica.SIunits.Area AFlo=8500 "Floor area";
  final parameter Modelica.SIunits.Length hRoo=3.2 "Average room height";
  final parameter Modelica.SIunits.MassFlowRate m_flow_nominal_water=5
    "Nominal mass flow rate for water loop";
  final parameter Modelica.SIunits.MassFlowRate m_flow_nominal_air=31
    "Nominal mass flow rate for air system";
  AirHandlingUnit airHandlingUnit(redeclare package Air = Air,
    m_flow_nominal=m_flow_nominal_air,
    m2_flow_nominal=m_flow_nominal_water,
    redeclare package Water = Water)
    annotation (Placement(transformation(extent={{-152,34},{-120,54}})));
  Buildings.ThermalZones.Detailed.MixedAir ou44Bdg(
    nConPar=0,
    nSurBou=0,
    nPorts=4,
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
    lat=0.96697872811643)
    annotation (Placement(transformation(extent={{-18,36},{22,76}})));
  final parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Insulation100Concrete200
    roof(material={insulationRoof,concreteRoof})
         annotation (Placement(transformation(extent={{176,192},{196,212}})));
  final parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Concrete200 floor(material=
        {concreteFloor})
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
    d=50,
    x=0.52)
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
        ModelicaServices.ExternalReferences.loadResource(
        "modelica://OU44/Weather/Copenhagen.mos"))
    annotation (Placement(transformation(extent={{110,80},{90,100}})));
  Buildings.BoundaryConditions.WeatherData.Bus weaBus annotation (Placement(
        transformation(extent={{18,70},{58,110}}),iconTransformation(extent={{-160,
            110},{-140,130}})));
  Modelica.Blocks.Math.MatrixGain matrixGain(K=[0.4; 0.4; 0.2])
    "Splits heat gains into radiant, convective and latent"
    annotation (Placement(transformation(extent={{-70,110},{-50,130}})));
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
  Buildings.Fluid.Sensors.TemperatureTwoPort tRadOut(redeclare package Medium
      = Water, m_flow_nominal=m_flow_nominal_water)
    annotation (Placement(transformation(extent={{-20,-132},{-40,-112}})));
  Infiltration infiltration(
    redeclare package Air = Air,
    Vi=AFlo*hRoo,
    ach=0.33) annotation (Placement(transformation(extent={{-92,6},{-72,26}})));
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
      package Water = Water) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-132,-44})));
  EnergyMeter energyMeterRad(m_flow_nominal=m_flow_nominal_water, redeclare
      package Water = Water) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={-94,-102})));
  EnergyMeter energyMeterMain(m_flow_nominal=m_flow_nominal_water, redeclare
      package Water = Water)  annotation (Placement(transformation(
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
  Modelica.Blocks.Math.Gain metHeat(k=120)
    "Metabolic heat generation per person (sensible and latent)"
    annotation (Placement(transformation(extent={{-108,110},{-88,130}})));
equation
  connect(airHandlingUnit.port_b1, ou44Bdg.ports[1])
    annotation (Line(points={{-120,40},{-60,40},{-60,43},{-13,43}},
                                                color={0,127,255}));
  connect(airHandlingUnit.port_a1, ou44Bdg.ports[2]) annotation (Line(points={{-120,48},
          {-60,48},{-60,45},{-13,45}},        color={0,127,255}));
  connect(weaBus, ou44Bdg.weaBus) annotation (Line(
      points={{38,90},{38,73.9},{19.9,73.9}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(matrixGain.y, ou44Bdg.qGai_flow) annotation (Line(points={{-49,120},{-36,
          120},{-36,64},{-19.6,64}}, color={0,0,127}));
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
  connect(infiltration.port_a, ou44Bdg.ports[3]) annotation (Line(points={{-72,22},
          {-58,22},{-58,47},{-13,47}},   color={0,127,255}));
  connect(infiltration.port_b, ou44Bdg.ports[4]) annotation (Line(points={{-72,10},
          {-56,10},{-56,49},{-13,49}},     color={0,127,255}));
  connect(weaBus, infiltration.weaBus) annotation (Line(
      points={{38,90},{-178,90},{-178,22},{-93.6,22}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(airHandlingUnit.weaBus, weaBus) annotation (Line(
      points={{-155,55.4},{-178,55.4},{-178,90},{38,90}},
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
    annotation (Line(points={{-72,120},{-87,120}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-240,
            -220},{240,220}}), graphics={Bitmap(
          extent={{-160,-162},{178,180}}, fileName="modelica://OU44/bitmaps/ou44.jpg")}),
                                                                 Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-240,-220},{240,
            220}})),
    experiment(StopTime=259200));
end BuildingBase;
