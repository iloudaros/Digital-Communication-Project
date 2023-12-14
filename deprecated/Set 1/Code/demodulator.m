function demodulated = demodulator(received_signal)
%% Author: Ioannis Loudaros, ΑΜ:1067400
%% Version: 1.0     Date: 18/01/2023
% received_signal : Το σήμα που παραλάβαμε από το κανάλι.
% demodulated : Το demodulated σήμα.

% Παράμετροι (Θα μπορούσαν να δίνονται ως είσοδοι στην συνάρτηση)
T_symbol = 4; % Περίοδος συμβόλου
T_sample = 0.1; % Περίοδος δειγματοληψίας
T_c = 0.4; % Περίοδος φέρουσας
F_c = 1 / T_c;
E_s = 1; % Ενέργεια ανά σύμβολο


% Δημιουργία κατάλληλου παλμού για την από-διαμόρφωση
g = sqrt(2 * E_s / T_symbol);

[~, T_symbol] = size(received_signal);

for t = 1: T_symbol
    y(t,1) = g * cos(2 * pi * F_c * t);
end

% Αποδιαμόρφωση 
demodulated = received_signal * y;




end