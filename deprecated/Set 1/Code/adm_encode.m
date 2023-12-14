function xq = adm_encode(x,M)
%% Author: Ioannis Loudaros, ΑΜ:1067400
%% Version: 0.1     Date: 19/01/2023

if ~(length(xq)>1)
    disp("Χρησιμοποιήστε κάποιο μεγαλύτερο σήμα.")
    return
end

x2=interp(x,M);

x2 = [0 x2]; % Δεν υπάρχει εύκολος τρόπος να προβλέψουμε το μέγεθος του xq αφού ο ρυθμός δειγματοληψίας αλλάζει κατά τη διάρκεια της κωδικοποίησης.

for i=1:length(x2)







end



if ~(length(xq)>1)
    disp("Χρησιμοποιήστε κάποιο μεγαλύτερο σήμα.")
end
end