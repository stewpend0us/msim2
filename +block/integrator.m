function this = integrator(numBlocks, varargin)
	assert(numBlocks > 0);
	this = strictlyProperBlock(numBlocks, numBlocks, numBlocks, [], @output, @physics, varargin{:});
end

function [dState, this] = physics(this, time, state, input)
dState = input;
end

function [output, this] = output(this, time, state)
output = state;
end

