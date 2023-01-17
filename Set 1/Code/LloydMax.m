function [xq, centers, D] =LloydMax(x, N, min_value, max_value)
%% Author: Ioannis Loudaros, ΑΜ:1067400
%% Version: 0.1     Date: 17/01/2023
% x : Σήμα εισόδου υπό την μορφή διανύσματος.
% N : Ο αριθμός των bits/sample που θα χρησιμοποιηθούν.
% max_value : Η μέγιστη αποδεκτή τιμή του σήματος εισόδου.
% min_value : Η ελάχιστη αποδεκτή τιμή του σήματος εισόδου.
% x_q : Το κωδικοποιημένο διάνυσμα εξόδου μετά από Kmax επαναλήψεις του
% αλγορίθμου.
% centers : Τα κέντρα των περιοχών κβάντισης μετά από Kmax επαναλήψεις του
% αλγορίθμου.
% D : Διάνυσμα που περιέχει τις τιμές [D_1:D_Kmax], όπου D_i αντιστοιχεί
% στη μέση παραμόρφωση στην i-οστή επανάληψη του αλγορίθμου.


xq=zeros(1,length(x)); %preallocation του xq για οικονομία χρόνου. N bits για το κάθε δείγμα.

% Δημιουργία των αρχικών επιπέδων κβάντισης
centers = linspace(min_value, max_value, 2^N+2);


% Περικοπή των δειγμάτων στις επιτρεπτές τιμές
if min(x) < min_value
    for i=1:length(x)
        if x(i) < min_value
            x(i) = min_value;
        end
    end
end
if max(x) > max_value
    for i=1:length(x)
        if x(i) > max_value
            x(i) = max_value;
        end
    end
end



% Δημιουργία του πίνακα των ορίων των ζωνών κβάντισης
T = zeros(1,length(centers)-1); % Κάνουμε pre-allocation για λόγους ταχύτητας.
T(1)= min_value;
T(end) = max_value;


D = []; % Καταγραφή μέσης παραμόρφωσης κάθε επανάληψης
% Βασική Επαναληπτική Διαδικασία
while(1)
    % Υπολογισμός των ορίων των ζωνών κβάντισης

    for i=2:(length(centers)-2)
        T(i) = (centers(i) + centers(i+1))/2;
    end

    counted = zeros(length(centers)); % Πίνακας για να αποθηκεύσουμε πόσα δείγματα κατατάχθηκαν σε κάθε ζώνη
    dist_mean = zeros(length(centers)); % Πίνακας για να αποθηκεύσουμε τη μέση παραμόρφωση των δειγμάτων που κατατάχθηκαν σε κάθε ζώνη
    total=0; % Θα χρησιμοποιηθεί αργότερα για το άθροισμα των στιγμιαίων παραμορφώσεων


    % Κατάταξη των δειγμάτων μέσα στις περιοχές κβάντισης
    for i=1:length(x)
        for j=1:length(T)-1
            if (T(j) <= x(i) && x(i) <= T(j+1)) % Ισοδυναμεί με σύνολα (...], εκτός από το πρώτο που είναι [...] για να κατατάσονται τυχόν δείγματα πάνω στο min_value
                xq(i) = j; % Αποθήκευση του επιπέδου κβάντισης του δείγματος

                % Κρατάμε τα στοιχεία για να υπολογίσουμε τα κεντροειδή
                counted(j)= counted(j)+1;
                dist_mean(j) = dist_mean(j)+x(i);

                % Κρατάμε το άθροισμα των στιγμιαίων παραμορφώσεων ώστε να
                % βγάλουμε μετά την μέση παραμόρφωση
                total = total + (centers(j+1) - x(i))^2;
            end
        end
    end

    % Εύρεση μέσης παραμόρφωσης του τελευταίου iteration
    avg_dist = total/length(x);
    D = [D avg_dist];


    % Συνθήκη τερματισμού του αλγορίθμου (Η βελτίωση της μέσης παραμόρφωσης δεν είναι αισθητή)
    if ( (length(D)>1) && (abs(D(end) - D(end-1)) < eps) )
        break;
    end


    % Αν δεν ικανοποιηθεί η συνθήκη, προετοιμάζουμε τα κέντρα για την
    % επόμενη επανάληψη
    for i=2:(length(centers)-1)
        if counted(i-1) ~= 0
            centers(i) = dist_mean(i-1)/counted(i-1);
        end
    end

end

centers = centers(2:end-1);
xq = dec2bin(xq-1);
end

