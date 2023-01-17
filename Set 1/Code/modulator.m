function modulated = modulator(symbol_seq, M)
%% Author: Ioannis Loudaros, ΑΜ:1067400
%% Version: 1.0     Date: 17/01/2023
% symbol_seq : Τα προς μετάδοση σύμβολα.
% Μ : Το πλήθος των συμβόλων.
% modulated : Ο προς μετάδωση παλμός.

T_symbol = 4; % Περίοδος συμβόλου
T_sample = 0.1; % Περίοδος δειγματοληψίας
T_c = 0.4; % Περίοδος φέρουσας
F_c = 1 / T_c;
E_s = 1; % Ενέργεια ανά σύμβολο

% Ο παλμός
g = sqrt(2 * E_s / T_symbol);

% Υπολογισμός του σήματος προς μετάδοση
for i = 1: length(symbol_seq)
    for t = 1: T_symbol/T_sample
        modulated(i, t) = g * cos( 2*pi*F_c*t - 2*pi*symbol_seq(i)/M );
    end
end
end
