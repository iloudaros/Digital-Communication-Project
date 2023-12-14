function [chopped, symbol_seq] = mapper(bin_seq, M, gray)
%% Author: Ioannis Loudaros, ΑΜ:1067400
%% Version: 1.0     Date: 17/01/2023
% bin_seq : Δυαδική ακολουθία προς μετατροπή σε σύμβολα.
% Μ : Το πλήθος των συμβόλων.
% gray : Επιλογή για το αν η ακολουθία συμβόλων θα είναι κωδικοποιημένη
% κατά gray (1) ή όχι (0).
% symbol_seq : Η ακολουθία συμβόλων που προκύπτει.
% chopped : bits της άρχικης ακολουθίας που αποκόπηκαν γιατί δεν μπορούσαν
% να γίνουν map.



% Περικοπή της ακολουθίας σε ακέραιο πολλαπλάσιο του log2(M)
overhead = mod(length(bin_seq), log2(M));
normalized_seq = bin_seq(1 : end - overhead);
chopped = bin_seq(length(normalized_seq)+1:end);

% Ανασχηματισμός της ακολουθίας σε στήλες log2(M) στοιχείων
to_be_mapped = reshape(normalized_seq, [log2(M), length(normalized_seq) / log2(M)]);


symbol_seq= [1,length(normalized_seq) / log2(M)]; %preallocation για να μην χρειάζεται να καταναλώνεται χρόνος σε realloc()


% % Για το overhead
% if overhead ~=0
%     chopped = bin_seq(length(normalized_seq)+1:end);
%     extention = zeros(1,log2(M)-overhead);
%     last_group = [extention chopped]';
% 
% 
% to_be_mapped = [to_be_mapped last_group];
% end

% Κάνουμε το mapping χρησιμοποιώντας για σύμβολα, ακέραιους αριθμούς
for i = 1: size(to_be_mapped,2)
    symbol_seq(i) = bin2dec(num2str(to_be_mapped(:, i)'));
end



if gray == 1
    symbol_seq = bin2gray(symbol_seq, 'pam', M);
end

end