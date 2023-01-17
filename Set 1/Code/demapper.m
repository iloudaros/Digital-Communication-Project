function bin_seq = demapper(symbol_seq, M, gray, chopped)
%% Author: Ioannis Loudaros, ΑΜ:1067400
%% Version: 0.1     Date: 17/01/2023
% Μ : Το πλήθος των συμβόλων.
% gray : Επιλογή για το αν η ακολουθία συμβόλων είναι κωδικοποιημένη
% κατά gray (1) ή όχι (0).
% symbols_seq : Η ακολουθία συμβόλων που παραλαμβάνεται.
% chopped : bits της άρχικης ακολουθίας που αποκόπηκαν γιατί δεν μπορούσαν
% να γίνουν map. Θα προστεθούν απλά στο τέλος, αν δοθούν.
% bin_seq : Δυαδική ακολουθία που προκύπτει από τα σύμβολα.


% Αν το chopped δεν περαστεί, είναι κενό.
if ~exist('chopped','var') % 
    chopped = [];
end


% Μετατροπή από gray σε binary αν χρειάζεται.
if gray == 1 
    symbol_seq = gray2bin(symbol_seq, 'pam', M);
end

% Μετατροπή από σύμβολα (ακέραιοι) σε binary.
bin_seq = dec2bin(symbol_seq);


% Επανασχηματισμός ώστε να είναι πάλι ροή από bit.
[n, m] = size(bin_seq);
bin_seq = reshape(bin_seq',1,m*n);
bin_seq = string(bin_seq);
bin_seq = strcat(bin_seq, string(chopped));
end