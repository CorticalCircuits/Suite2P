function exptChars = makeExptChars(db);

exptChars = num2str(db.expts(1));
for i = 2:length(db.expts),exptChars = [exptChars,'_',num2str(db.expts(i))];
end