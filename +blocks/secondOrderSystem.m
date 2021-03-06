function [b] = secondOrderSystem( storage )
% storage is a struct array with fields "zeta" and "omega_n"
    numBlocks = numel(storage);
    assert(numBlocks>0);
	b = struct;
	b.numInputs = numBlocks;
	b.numOutputs = numBlocks;
	b.numStates = 2 * numBlocks;
	b.storage = storage;
	b.f = @physics;
	b.h = @output;
end

function [dState, storage] = physics(...
	numStates,...
	numInputs,...
	time,...
	state,...
	input,...
	storage...
)
	statei = 1:numInputs;
	state1 = state(statei);
	state2 = state(statei + numInputs);
	
	wn = [storage.omega_n];
	zeta = [storage.zeta];

	dState1 = state2;
	dState2 = -2 * zeta .* wn .* state2 - wn .* wn .* ( state1 - input );
    dState = [dState1 dState2];
end

function [output, storage] = output(...
	numStates,...
	numOutputs,...
	time,...
	state,...
	storage...
)
	output = state(1:numOutputs);
end

