classdef ShellElement < handle
	properties
		% Element properties
		id (1,1) {mustBePositive, mustBeInteger} = 1;
		nodeI;
		nodeJ;
		nodeK;
		nodeL;
		
		% Material properties
		elasticityModulus;
		poissonsRatio;
		shearModulus;
		
		% Section properties
		thickness
		
		% Stifness
		kMembrane; % Stiffness of drilling part
		kPlate; % Stifness of plate part
		K; % Shell stiffness
		
		% Rotation
		r; % Node
		R; % Element
		
		% Equation numbering
		eqnNumbering;
		
		
	end
	methods
		function this = ShellElement(id, nodeI, nodeJ, nodeK, nodeL, material, thickness)
			this.id = id;
			this.nodeI = nodeI;
			this.nodeJ = nodeJ;
			this.nodeK = nodeK;
			this.nodeL = nodeL;
			
			this.eqnNumbering = [this.nodeI.globalDofIds;
				this.nodeJ.globalDofIds;
				this.nodeK.globalDofIds;
				this.nodeL.globalDofIds];
			
			
			this.elasticityModulus = material(1);
			this.poissonsRatio = material(2);
			this.shearModulus = this.elasticityModulus / (2 * (1 + this.poissonsRatio));
			
			this.thickness = thickness;
			
			[this.r, this.R] = formRotation(this);
			this.K = formStiffnessShell(this);
			
			
		end
		
		D4 = D4(this, ksi, eta)
		kD = AddDrilling(this, V)
		dN4_dEta = dN4_dEta(this, ksi, eta)
		dN4_dKsi = dN4_dKsi(this, ksi, eta)
		dN4_dX = dN4_dX(this, JI, ksi, eta)
		dN4_dY = dN4_dY(this, JI, ksi, eta)
		dNS_dEta = dNS_dEta(this, ksi, eta)
		dNS_dKsi = dNS_dKsi(this, ksi, eta)
		dNS_dX = dNS_dX(this, JI, ksi, eta)
		dNS_dY = dNS_dY(this, JI, ksi, eta)
		C = formConstitutiveRelationMembrane(this)
		C = formConstitutiveRelationPlateBending(this)
		C = formConstitutiveRelationPlateShear(this)
		B = formCurvatureDisplacementRelationPlate(this, ksi, eta, JI)
		J = formJacobian(this, ksi, eta, XY)
		[r, R] = formRotation(this)
		kMembrane = formStiffnessMembrane(this, XY, Loc, Wgt)
		kPlate = formStiffnessPlate(this, XY, Loc, Wgt)
		kPlateBending = formStiffnessPlateBending(this, XY, Loc, Wgt, nGaussBending)
		kPlateShear = formStiffnessPlateShear(this, XY, Loc, Wgt, nGaussShear)
		K = formStiffnessShell(this)
		B = formStrainDisplacementRelationMembrane(this, ksi, eta, JI, XY)
		B = formStrainDisplacementRelationPlate(this, ksi, eta, JI)
		N4 = N4(this, ksi, eta)
		Normal_x_Length = Normal_x_Length(this, XY)
		[XY, T] = planar(this)
		T = twist(this, XYZ)
		
	end
end
