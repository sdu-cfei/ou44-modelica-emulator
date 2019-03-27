within OU44Emulator.Models.Validation;
model PeriodicFullOccupancy
  extends BuildingControl;
  Modelica.Blocks.Sources.Pulse pulse(
    startTime=3600*7,
    width=33,
    period=3600*24,
    amplitude=1)
    annotation (Placement(transformation(extent={{-230,114},{-210,134}})));
equation
  connect(pulse.y, firstOrder.u)
    annotation (Line(points={{-209,124},{-194,124}}, color={0,0,127}));
  annotation (experiment(StopTime=2678400, Interval=3600));
end PeriodicFullOccupancy;
