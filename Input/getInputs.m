function [XYZ, supports, connectivity, materials, sections, thicknesses, elementTypes, materialIds, sectionIds, nodalLoads] = getInputs()

XYZ = read('Inputs.xlsx', 'Coordinates', 'B2:D3000');

supports = read('Inputs.xlsx', 'Supports', 'B2:H3000');

lineElement = read('Inputs.xlsx', 'Line Elements', 'A2:A2');
shellElement = read('Inputs.xlsx', 'Shell Elements', 'A2:A2');
thicknesses = 0;
sectionIds = 0;
if(~isempty(lineElement))
    connectivity = read('Inputs.xlsx', 'Line Elements', 'C2:D3000');
    materialIds = read('Inputs.xlsx', 'Line Elements', 'E2:E3000');
    sectionIds = read('Inputs.xlsx', 'Line Elements', 'F2:F3000');
    elementTypes = read('Inputs.xlsx', 'Line Elements', 'B2:B3000');
elseif(~isempty(shellElement))
    connectivity = read('Inputs.xlsx', 'Shell Elements', 'C2:F3000');
    thicknesses = read('Inputs.xlsx', 'Shell Elements', 'G2:G3000');
    materialIds = read('Inputs.xlsx', 'Shell Elements', 'H2:H3000');
    elementTypes = read('Inputs.xlsx', 'Shell Elements', 'B2:B3000');
else
    throw(MException('MyComponent:noSuchVariable','There is no elements in the input file!'));
end

materials = read('Inputs.xlsx', 'Materials', 'B2:C3000');

[sectionsNumericData,momentCurvatureSheetNames] =  xlsread('Inputs.xlsx', 'Sections', 'B2:I3000');
sections = num2cell(sectionsNumericData);
for i = 1:size(sections,1)
    sections{8} = read('Inputs.xlsx', momentCurvatureSheetNames{i}, 'A2:B3000');
end

nodalLoads = read('Inputs.xlsx', 'Nodal Load', 'B2:H3000');

end