within OU44Emulator;
package Documentation "Documentation"
  extends Modelica.Icons.Information;

  annotation (preferredView="info",
  Documentation(info="<html>
  
  <h3>Single-zone emulator (SDU)</h3>
    
    <p align=\"left\"><img src=\"modelica://OU44Emulator/Resources/Images/ou44.jpg\" height=\"266\" alt=\"OU44 building\"/></p>
    
    <!-- Section 1 -->
    <h3>Building Design and Use</h3>
    <p>
    The overall description of the actual building can be found in the following paper:
    <a href=\"https://www.sciencedirect.com/science/article/pii/S1876610217347720\">M. Jradi et al., A World Class Energy Efficient 
    University Building by Danish 2020 Standards, Energy Procedia 132 (2017), 21-26.</a>
    
    The following documentation contains only information relevant for the simplified model included in BOPTEST.
    </p>
    
    <h4>Architecture</h4>
    <p>
    The building surface area is 8500 m2. There are 3 above-ground floors containing classrooms (40% of floor area), study zones (25%), offices (15%), and common spaces (20%).
    There is also a basement level containing main HVAC facilities and the main heat exchanger connected to district heating.
    The building can accommodate around 1350 people.
    </p>
    
    <h4>Constructions</h4>
    <p>
    The building thermal envelope is comprised of three different opaque constructions: ground floor (<code>floor</code>), external wall (<code>extWall</code>), and roof (<code>roof</code>).
    The internal walls are modeled by a single-layer generic construction representing medium-weight partitions.
    All opaqua construction layers and thermal characteristics are described in Table 1. All windows are modeled using the same contruction type, based on a triple-glass window model from the <code>Buildings</code> library
    (<code>Buildings.HeatTransfer.Data.GlazingSystems.TripleClearAir13ClearAir13Clear</code>),
    with the following layers: triple pane, clear glass 3mm, air 12.7 mm, clear glass 3mm, air 12.7 mm, clear glass 3mm.
    
    <table border=\"1\"><caption><b>Table 1:</b> Opaque constructions and their thermal parameters (x - width [m], k - conductivity [W/(mK)], c - specific heat [J/(kgK)], d - density [g/cm3]) </caption>
      <thead>
        <tr>
            <th>Construction</th>
            <th>Layers</th>
            <th>Parameters (x, k, c, d)</th>
        </tr>
      </thead>
      <tbody>
        <tr>
            <td><code>floor</code></td>
            <td>Concrete</td>
            <td>0.2, 1.4, 840, 2.24</td>
        </tr>
        <tr>
            <td></td>
            <td>Insulation</td>
            <td>0.15, 0.04, 1000, 0.05</td>
        </tr>
        <tr>
            <td><code>extWall</code></td>
            <td>Concrete</td>
            <td>0.2, 1.4, 840, 2.24</td>
        </tr>
        <tr>
            <td></td>
            <td>Insulation</td>
            <td>0.27, 0.04, 1000, 0.05</td>
        </tr>
        <tr>
            <td><code>roof</code></td>
            <td>Concrete</td>
            <td>0.27, 1.4, 840, 2.24</td>
        </tr>
        <tr>
            <td></td>
            <td>Insulation</td>
            <td>0.52, 0.04, 1000, 0.05</td>
        </tr>
        <tr>
            <td><code>intWall</code></td>
            <td>Generic material</td>
            <td>0.15, 0.5, 1000, 0.25</td>
        </tr>
      </tbody>
    </table>
    </p>
    
    <h4>Occupancy schedules and comfort requirements</h4>
    <p>
    ...
    </p>
    
    <h4>Internal loads and schedules</h4>
    <p>
    ...
    </p>
    
    <h4>Climate</h4>
    <p>
    The weather data is based on Copenhagen Typical Meteorological Year. The weather file is located in <code>modelica://OU44Emulator/SingleZone/Resources/Weather/DNK_Copenhagen.061800_IWEC.mos</code>.
    </p>
    
    <!-- Section 2 -->
    <h3>HVAC System Design</h3>   
    <h4>Primary and secondary system designs</h4>
    The actual building is equipped with 4 balanced Air Handling Units (AHU) with heat recovery wheels and pre-heating coils (Fig. 1) and each room is equipped with radiator heating.
    The heating is provided by district heating grid. 
    Since the model is a single-zone model, all AHUs are modeled with a single AHU oversized by a factor of 4, and all radiators are modeled with a single radiator.
    The following description covers the HVAC design as implemented in the model, and not the HVAC system in the actual building.
    
    The AHU contains two identical fans, one for supply air and one for extract air. The nominal air volume flow rate capacity is 140000 m3/h.
    Both the radiator and the pre-heating coil in the AHU are connected to the main heat exchanger connected to the district heating grid.
    The water flow to the radiator and AHU's pre-heating coil is controlled with two 3-way valves.
    
    <p align=\"left\"><b>Fig. 1:</b> Air Handling Unit diagram with exemplary measurements from the BMS system (screenshot).<br>
    <img src=\"modelica://OU44Emulator/Resources/Images/bms_ahu.png\" height=\"500\" alt=\"AHU\"/></p>
    <p>
    ...
    </p>
    
    <h4>Equipment specifications and performance maps</h4>
    <p>
    ...
    </p>
    
    <h4>Rule-based or local-loop controllers</h4>
    <p>
    </p>
    
    <!-- Section 3 -->
    <h3>Additional System Design</h3>
    <h4>Lighting</h4>
    <p>
    ...
    </p>
    
    <h4>Shading</h4>
    <p>
    ...
    </p>
    
    <h4>Onsite generation and storage</h4>
    <p>
    There is no onsite power generation or energy storage in the model.
    </p>
    
    <!-- Section 4 -->
    <h3>Points List</h3>
    <h4>Control input signals, descriptions, and meta-data</h4>
    <p>
    ...
    </p>
    
    <h4>Measurement output signals, descriptions, and meta-data</h4>
    <p>
    ...
    </p>
    
    <!-- Section 5 -->
    <h3>Important Model Implementation Assumption</h3>
    <p>
    The major assumptions are as follows:
    <ul>
      <li>Single zone used to model the entire building.</li>
      <li>Single Air Handling Unit (AHU) used to model 4 actual AHUs. Fans in the AHU oversized by a factor of 4.</li>
      <li>Single radiator representing all radiators in the building.</li>
      <li>Constant infiltration rate of 0.33 air changes per hour.</li>
      <li>Constant ground temperature 10 degC.</li>
      <li>Constant efficiency of heat exchangers.</li>
      <li>Internal heat gains (100%) are divided into radiative (40%), convective (40%), and latent gains (20%). These proportions are constant.</li>
      
    </ul>
    </p>
    
    <!-- Section 6 -->
    <h3>Scenario Information</h3>
    <h4>Energy pricing</h4>
    <p>
    ...
    </p>
    
    <h4>Emission factors</h4>
    <p>
    ...
    </p>

    </html>"));

end Documentation;
