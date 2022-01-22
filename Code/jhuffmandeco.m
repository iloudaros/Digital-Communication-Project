function sig = jhuffmandeco(code,dict)
% Author: Ioannis Loudaros, ΑΜ:1067400

flag=0; % Σημαία για την πρώτη φορά που θα βρούμε αντιστοιχία
start=1; % Συμβολίζει το πρώτο στοιχείο του code που κοιτάμε κάθε φορά να δούμε αν μπορούμε να αντιστοιχίσουμε

for i = 1 : height(code)

    temp = code(start:i); % Μια λέξη από το στοιχείο start mέχρι το
    check = keyofvalue(dict,temp'); % Αυτή η λέξη είναι huff του λεξικού;

    if ~isempty(check)% Αν είναι τότε βάλε το αρχικό σύμβολο στην έξοδο

        
        if flag==0
            sig= check; 
            flag=1;
        else
            sig = [sig ; check];
        end    

        start = i+1;% Και άρχισε να κοιτάς από το επόμενο ψηφίο του Code

    end

end

sig = cell2mat(sig);

end