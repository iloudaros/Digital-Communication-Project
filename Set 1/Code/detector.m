function symbol_seq = detector(demodulated,M)
%% Author: Ioannis Loudaros, ΑΜ:1067400
%% Version: 1.0     Date: 18/01/2023
% received_signal : Το σήμα που παραλάβαμε από το κανάλι.
% demodulated : Το demodulated σήμα.
% symbol_seq : Η ακολουθία συμβόλων που περιεχόταν μέσα στο σήμα.

% Πλήθος συγκρίσεων που πρέπει να γίνουν.
[nlines, ~]=size(demodulated);

% Καθορισμός κατάλληλων συχνοτήτων για κάθε σύμβολο.
for i = 1: M
    s(i, 1) = cos( 2 * pi * i / M );
end


% Διαπερνάμε το demodulated και το συγκρίνουμε με κάθε σύμβολο. Η μικρότερη
% διαφορά είναι αυτή που μας δείχνει την αντιστοίχιση.
for j =1: nlines
    for i = 1: M
        diff(i, 1) = abs([demodulated(j,1)] - s(i,:));
    end
    [~, symbol_seq(j, 1)] = min(diff);
end

symbol_seq = mod(symbol_seq,M);


end