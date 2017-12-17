function this = firstOrderLag(tau, varargin)
    numBlocks = numel(tau);
    assert(numBlocks > 0);
	this = strictlyProperBlock(numBlocks, numBlocks, numBlocks, tau, @output, @physics, varargin{:});
end

function [dState, this] = physics(this, time, state, input)
	dState = (input - state) ./ this.storage;
end

function [output, this] = output(this, time, state)
    output = state;
end

