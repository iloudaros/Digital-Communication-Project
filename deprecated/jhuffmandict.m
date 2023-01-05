function [dict] = jhuffmandict(symbols,prob)
% Author: Ioannis Loudaros, ΑΜ:1067400

huff=cell(height(symbols),1); % Φτιάχνουμε ένα cell Array που κάθε του κελί θα φιλοξενήσει την κωδικοποίηση του κάθε συμβόλου
dict = containers.Map(symbols,huff,'UniformValues',false); % Φτιάχνουμε το λεξικό ώστε να αναφερόμαστε έυκολα σε κάθε κωδικοποίηση

temp = cell(height(symbols),2); % Φτιάχνω ένα cell array στο οποίο θα εκτελέσουμε τον αλγόριθμο

for i = 1:height(symbols)
    temp{i,1}=symbols{i};
    temp{i,2}=prob(i);
end

for i = 1:height(symbols)-1

    temp = sortrows(temp,2,'descend');

    for j = 1:length(temp{end-1,1}) %Πρόσθεσε 0 στο huff των συμβόλων που υπάρχουν στην προτελευταία γραμμή
        t = dict(temp{end-1,1}(j));
        t(end+1)=0;
        dict(temp{end-1,1}(j))=t;
    end

    for j = 1:length(temp{end,1}) %Πρόσθεσε 1 στο huff των συμβόλων που υπάρχουν στην τελευταία γραμμή
        t = dict(temp{end,1}(j));
        t(end+1)=1;
        dict(temp{end,1}(j))=t;
    end

    % Φτιάξε το σύνθετο σύμβολο από τα 2 τελευταία 
    temp{end-1,1}=[temp{end-1,1} temp{end,1}];
   % temp{end-1,1}(end+1)=temp{end,1};
    temp{end-1,2}= temp{end-1,2} + temp{end,2};
    temp(end,:)=[];

end


for i =  cell2mat(dict.keys)
    dict(i) = fliplr(dict(i));
end

end