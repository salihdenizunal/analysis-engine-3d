function [XYZ, supports, connectivity, materials, sections, thicknesses, elementTypes, materialIds, sectionIds, nodalLoads, deltaL, phi, tolerance, maxIteration, numIncrement, strainType, initialStartNodeDisp, initialEndNodeDisp] = getInputs()

XYZ = read('Inputs.xlsx', 'Coordinates', 'B2:D3000');

supports = read('Inputs.xlsx', 'Supports', 'B2:H3000');

lineElement = read('Inputs.xlsx', 'Line Elements', 'A2:A2');
nonlinearLineElement = read('Inputs.xlsx', 'Nonlinear Line Elements', 'A2:A2');
shellElement = read('Inputs.xlsx', 'Shell Elements', 'A2:A2');
thicknesses = 0;
sectionIds = 0;
strainType = 0;
initialStartNodeDisp = 0;
initialEndNodeDisp = 0;
if(~isempty(lineElement))
    connectivity = read('Inputs.xlsx', 'Line Elements', 'C2:D3000');
    materialIds = read('Inputs.xlsx', 'Line Elements', 'E2:E3000');
    sectionIds = read('Inputs.xlsx', 'Line Elements', 'F2:F3000');
    elementTypes = read('Inputs.xlsx', 'Line Elements', 'B2:B3000');
elseif(~isempty(nonlinearLineElement))
    connectivity = read('Inputs.xlsx', 'Nonlinear Line Elements', 'C2:D3000');
    materialIds = read('Inputs.xlsx', 'Nonlinear Line Elements', 'E2:E3000');
    sectionIds = read('Inputs.xlsx', 'Nonlinear Line Elements', 'F2:F3000');
    elementTypes = read('Inputs.xlsx', 'Nonlinear Line Elements', 'B2:B3000');
    strainType = read('Inputs.xlsx', 'Nonlinear Line Elements', 'S2:S3000');
    initialStartNodeDisp = read('Inputs.xlsx', 'Nonlinear Line Elements', 'G2:L3000');
    initialEndNodeDisp = read('Inputs.xlsx', 'Nonlinear Line Elements', 'M2:R3000');
elseif(~isempty(shellElement))
    connectivity = read('Inputs.xlsx', 'Shell Elements', 'C2:F3000');
    thicknesses = read('Inputs.xlsx', 'Shell Elements', 'G2:G3000');
    materialIds = read('Inputs.xlsx', 'Shell Elements', 'H2:H3000');
    elementTypes = read('Inputs.xlsx', 'Shell Elements', 'B2:B3000');
else
    throw(MException('MyComponent:noSuchVariable','There is no elements in the input file!'));
end

materials = read('Inputs.xlsx', 'Materials', 'B2:C3000');

sections = read('Inputs.xlsx', 'Sections', 'B2:E3000');

nodalLoads = read('Inputs.xlsx', 'Nodal Load', 'B2:H3000');

deltaL = read('Inputs.xlsx', 'Arc Length Parameters', 'A2:A2');

phi = read('Inputs.xlsx', 'Arc Length Parameters', 'B2:B2');

tolerance = read('Inputs.xlsx', 'Arc Length Parameters', 'C2:C2');

maxIteration = read('Inputs.xlsx', 'Arc Length Parameters', 'D2:D2');

numIncrement = read('Inputs.xlsx', 'Arc Length Parameters', 'E2:E2');

end