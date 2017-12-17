function this = strictlyProperBlock(numInputs, numOutputs, numStates, storage, output, physics, util)
	this.numInputs = numInputs;
	this.numOutputs = numOutputs;
	this.numStates = numStates;
	this.storage = storage;
	this.h = output;
	this.f = physics;
    if exist('util','var')
        this.u = util;
    else
        this.u = [];
    end
end