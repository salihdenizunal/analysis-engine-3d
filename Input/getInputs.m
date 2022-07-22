function [XYZ, supports, connectivity, materials, sections, thicknesses, elementTypes, materialIds, sectionIds, nodalLoads] = getInputs(inputFileName)

    XYZ = read(inputFileName, 'Coordinates', 'B2:D3000');

    supports = read(inputFileName, 'Supports', 'B2:H3000');

    lineElement = read(inputFileName, 'Line Elements', 'A2:A2');
    shellElement = read(inputFileName, 'Shell Elements', 'A2:A2');
    thicknesses = 0;
    sectionIds = 0;
    if(~isempty(lineElement))
        connectivity = read(inputFileName, 'Line Elements', 'C2:D3000');
        materialIds = read(inputFileName, 'Line Elements', 'E2:E3000');
        sectionIds = read(inputFileName, 'Line Elements', 'F2:F3000');
        elementTypes = read(inputFileName, 'Line Elements', 'B2:B3000');
    elseif(~isempty(shellElement))
        connectivity = read(inputFileName, 'Shell Elements', 'C2:F3000');
        thicknesses = read(inputFileName, 'Shell Elements', 'G2:G3000');
        materialIds = read(inputFileName, 'Shell Elements', 'H2:H3000');
        elementTypes = read(inputFileName, 'Shell Elements', 'B2:B3000');
    else
        throw(MException('MyComponent:noSuchVariable','There is no elements in the input file!'));
    end

    materials = read(inputFileName, 'Materials', 'B2:C3000');

    [sectionsNumericData,momentCurvatureSheetNames] =  xlsread(inputFileName, 'Sections', 'B2:I3000');
    sections = num2cell(sectionsNumericData);
    for i = 1:size(sections,1)
        sections{8} = read(inputFileName, momentCurvatureSheetNames{i}, 'A2:B3000');
    end

    nodalLoads = read(inputFileName, 'Nodal Load', 'B2:H3000');

end
