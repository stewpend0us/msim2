function this = blockSystem(blocks, numInputs, numOutputs, calcBlockInputs, calcSystemOutput)
storage.numBlocks = numel(blocks);
storage.blocks = blocks;
storage.blockInputs = {};
storage.blockOutputs = {};
storage.calcBlockInputs = calcBlockInputs;
storage.calcSystemOutput = calcSystemOutput;
storage.systemStorage = systemStorage;

numStates = sum([blocks.numStates]);
this = strictlyProperBlock(numInputs, numOutputs, numStates, storage, @output, @physics, @util);
end

% BlockSystem
function [dState, this] = physics(this, time, state, input)
% update all of the block outputs based on the latest state
xi = 0;
for i = 1:this.storage.numBlocks
    statei = xi + (1:this.blocks(i).numStates);
    [this.storage.blockOutputs{i}, this.blocks(i)] = this.storage.blocks(i).h(this.storage.blocks(i), time, state(statei));
    xi = xi + this.blocks(i).numStates;
end
% calculate the block inputs from the updated block outputs
[this.storage.blockInputs, this.storage] = storage.calcBlockInputs( this.storage.numBlocks, this.storage.blocks, time, this.storage.blockOutputs, numInputs, input, this.storage.systemStorage );
% finally calculate the block dstate from the updated block inputs
xi = 0;
dState = zeros(1,numStates);
for i = 1:this.storage.numBlocks
    statei = xi + (1:this.blocks(i).numStates);
    [dState(statei), this.blocks(i).storage] = this.storage.blocks(i).f(this.storage.blocks(i), time, state(statei), this.storage.blockInputs{i});
    xi = xi + this.blocks(i).numStates;
end
end

function [output, this] = output(this, time, state)
xi = 0;
for i = 1:this.storage.numBlocks
    statei = xi + (1:this.blocks(i).numStates);
    [this.storage.blockOutputs{i}, this.storage.blocks(i)] = this.storage.blocks(i).h(this.storage.blocks(i), time, state(statei));
    xi = xi + this.storage.blocks(i).numStates;
end

[output, this.storage] = storage.calcSystemOutput( this.storage.numOutputs, time, this.storage.blockOutputs, this.storage.systemStorage);
end


