function Success = Check(Acolouring,Gindex,Permutations)
    Success = 1;
    for i=1:length(Gindex)
        Bcolouring(i)=Permutations{Gindex(i,1)}{Gindex(i,2)}{Gindex(i,3)}(Acolouring(1,i));
    end
    ToCheck = [Gindex(:,2) Bcolouring'];
    for i=1:max(Gindex(:,2))
        Checking = ToCheck(ToCheck(:,1)==i,:);
        if (length(Checking(:,1)) ~= length(unique(Checking(:,2))))
            Success = 0;
            return
        end
    end
end