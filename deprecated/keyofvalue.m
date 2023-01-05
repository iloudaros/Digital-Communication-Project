function key = keyofvalue(dict,value)
% Author: Ioannis Loudaros, ΑΜ:1067400

testind = cellfun(@(x)isequal(x,value),values(dict));

testkeys = keys(dict);

key = testkeys(testind);
end