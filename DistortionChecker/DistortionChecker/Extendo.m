function AB = Extendo(A,B)
    % for A of size 'n1 by n2' and B of size 'm1 by m2'
    % returns AB of size 'n1m1 by n2+m2'
    % AB is a block matrix made up of 'm1 by 2' blocks
    % block (i,1) is of size 'm1 by n2' and 
    % has the ith row of A in each row
    % block (i,2) is of size 'm1 by m2' and is B
    Alength = size(A,1);
    Blength = size(B,1);
    AB = zeros(Alength*Blength,size(A,2)+size(B,2));
    for i=1:Alength
        for j=1:Blength
            AB((i-1)*Blength+j,:) = [A(i,:) B(j,:)];
        end
    end
end