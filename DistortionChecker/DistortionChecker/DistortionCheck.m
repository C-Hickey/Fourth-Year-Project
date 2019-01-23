clearvars

%CHANGE THIS TO THE NUMBER OF COLOURS YOU WANT
NColours  = 7;

Col = 1:NColours;

%the following matrix means that there are G(i,j) edges between the vertex
% Aj and Bi where the bipartite graph has a bipartition of vertices {A,B}.

Graph = [2 1 1
         1 0 1 
         1 1 2];     % Graph(row, column)

[NAvertices,NBvertices] = size(Graph); % n vertices on left side, m vertices on right




% this bit fills in the edge distortions randomly. You can input your own
% if necessary
for i = 1:NAvertices                  % A side
    for j = 1:NBvertices              % B side
        for k = 1:Graph(i,j) % Edges leaving the A vertex
            %this is the edge distortion of the 'k'th edge from Ai to Bj 
            Permutations{j}{i}{k} = randperm(NColours);
        end
    end
end

% we now go through each of the colourings possible for this 
% distortion colouring problem and see if we can find 
% one that works


combos = perms(Col);
Nincident = sum(Graph);

disp('Filling list of potential colourings')
disp('(yeah, this is a really inefficient method, but it works (I think))')

%each row of A is a potential distortion colouring
Acolouring = unique(combos(:,1:Nincident(1)),'rows');

for i=2:NAvertices %for each vertex on the A side
    %we create the possible colour combinations we can have on that vertex
    B = unique(combos(:,1:Nincident(i)),'rows');
    Acolouringnew = zeros(length(B)*length(Acolouring),sum(Nincident));
    Acolouringnew = Extendo(Acolouring,B);
    Acolouring=Acolouringnew;
end

%next it goes through each colouring, and checks if it works

%first, this bit of code allows us to easily access the permutations
%for each edge.
% Gindex(:,1) is the index of the vertex on the A side
% Gindex(:,2) is the index of the vertex on the B side
% Gindex(:,3) is the index of the edge between these two vertices
k=1;
for i=1:3
    for j=1:3
        for m = 1:Graph(j,i)
            Gindex(k,1:3) =[i , j , m];
            k=k+1;
        end
    end
end

disp(['Starting Checking, this might take a while, there are ' num2str(length(Acolouring)) ' colourings to check'])

for i=1:length(Acolouring)
    Success = Check(Acolouring(i,:),Gindex,Permutations);
    if Success == 1
        disp(['A successful distortion colouring was found after ' num2str(i) ' attempts.'])
        disp('The colouring of the A side of the graph is')
        Acolouring(i,:)
        return
    end
end

