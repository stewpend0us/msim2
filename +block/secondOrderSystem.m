function this = secondOrderSystem( storage, varargin )
% storage is a struct array with fields "zeta" and "omega_n"
    numBlocks = numel(storage);
    assert(numBlocks > 0);
	this = strictlyProperBlock(numBlocks, numBlocks, 2*numBlocks, storage, @output, @physics, varargin{:});
end

function [dState, this] = physics(this, time, state, input)
	statei = 1:this.numInputs;
	state1 = state(statei);
	state2 = state(statei + this.numInputs);
	
	wn = [this.storage.omega_n];
	zeta = [this.storage.zeta];

	dState1 = state2;
	dState2 = -2 * zeta .* wn .* state2 - wn .* wn .* ( state1 - input );
    dState = [dState1 dState2];
end

function [output, this] = output(this, time, state)
	output = state(1:this.numOutputs);
end

