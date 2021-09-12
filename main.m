clc
clear all

[XYZ, supports, connectivity, materials, sections, thicknesses, elementTypes, materialIds, sectionIds, nodalLoads, deltaL, phi, tolerance, maxIteration, numIncrement, strainType, initialStartNodeDisp, initialEndNodeDisp] = getInputs();
[Kg, elements, nodes] = constructStructure (XYZ, supports, connectivity, materials, sections, elementTypes, materialIds, sectionIds, thicknesses, strainType);
[tangentialForce, dispAtIncrement, numIteration] = arcLength(XYZ, supports, elements, nodes, nodalLoads, deltaL, phi, tolerance, maxIteration, numIncrement);

plot(dispAtIncrement(2,:),tangentialForce(2,:))