classdef Node
   properties 
      id (1,1) {mustBePositive, mustBeInteger} = 1;
      coordinates (1,3) double;
      globalDofIds;
   end
   methods
       function this = Node(id, coordinates, globalDofIds)
            this.id = id;
            this.coordinates = coordinates; 
            this.globalDofIds = globalDofIds;
      end
   end
end
