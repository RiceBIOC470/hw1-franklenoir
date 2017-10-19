GB Comments:
Prob1: 100%
Prob2:
P1:100
P2: 50 Within the for loop, the code doesn’t find the longest possible ORF and doesn’t check to be sure the sequence is in-frame of the start codon. 
P3:100
P4:90 Code is fine except for the issues propagated from part 2.  However, the graph does not labels to explain the X and Y axis.  
P5:100 
Prob3
P1: 50 variable line1 is exchanged from a character to a double in the while loop. Within the loop the, the script breaks because the function strsplit is trying to pass a variable that is a double when it needs a string. 
P2: 75 your variable plate has a non-scalar within the first index of the cell array. This causes cellfun to break when you try to pass the plate variable into it. 
P3: 90 no labels on graphs
Overall: 84


% Walter Frank Lenoir

% Homework 1. Due before class on 9/5/17

%% Problem 1 - addition with strings
%Walter Frank Lenoir

% Fill in the blank space in this section with code that will add 
% the two numbers regardless of variable type. Hint see the matlab
% functions ischar, isnumeric, and str2num. 

%your code should work no matter which of these lines is uncommented. 
x = 3; y = 5; % integers
%x = '3'; y= '5'; %strings
%x = 3; y = '5'; %mixed

%your code goes here
if ischar(x) || ischar(y)
    if ischar(x)
        x = str2num(x);
    end
    if ischar(y)
        y = str2num(y);
    end
end
sum = x + y;
%% Problem 2 - our first real biology problem. Open reading frames and nested loops.
%Walter Frank Lenoir

%part 1: write a piece of code that creates a random DNA sequence of length
% N (i.e. consisting of the letters ATGC) where we will start with N=500 base pairs (b.p.).
% store the output in a variable
% called rand_seq. Hint: the function randi may be useful. 
% Even if you have access to the bioinformatics toolbox, 
% do not use the builtin function randseq for this part. 

N = 500; % define sequence length
nuc = {'A','T','G','C'};
rand_numseq = randi([1 4],[1,N]);
rand_seq = "";
for i = 1:N
    rand_seq = rand_seq + string(nuc(rand_numseq(i)));
end

rand_seq;

%part 2: open reading frames (ORFs) are pieces of DNA that can be
% transcribed and translated. They start with a start codon (ATG) and end with a
% stop codon (TAA, TGA, or TAG). Write a piece of code that finds the longest ORF 
% in your seqeunce rand_seq. Hint: see the function strfind.


ORFS = [];
starts = strfind(rand_seq,"ATG");
stop1 = strfind(rand_seq,"TAG");
stop2 = strfind(rand_seq,"TGA");
stop3 = strfind(rand_seq,"TAA");

stops = horzcat(stop1,stop2,stop3);

for i = 1:length(starts)
    ORF = min(stops(starts(i) < stops));
    ORF = ORF - starts(i);
    ORFS = horzcat(ORFS,ORF);
end

maxORF = max(ORFS);

%part 3: copy your code in parts 1 and 2 but place it inside a loop that
% runs 1000 times. Use this to determine the probability
% that an sequence of length 500 has an ORF of greater than 50 b.p.
count = 0;
for k = 1:1000
    N = 500; % define sequence length
    nuc = {'A','T','G','C'};
    rand_numseq = randi([1 4],[1,N]);
    rand_seq = "";
    for i = 1:N
        rand_seq = rand_seq + string(nuc(rand_numseq(i)));
    end

    ORFS = [];
%Checking ORFs for generated side
    starts = strfind(rand_seq,"ATG");
    stop1 = strfind(rand_seq,"TAG");
    stop2 = strfind(rand_seq,"TGA");
    stop3 = strfind(rand_seq,"TAA");

    stops = horzcat(stop1,stop2,stop3);

    for i = 1:length(starts)
        ORF = min(stops(starts(i) < stops));
        ORF = ORF - starts(i);
        ORFS = horzcat(ORFS,ORF);
    end
    maxORF = max(ORFS);
    if maxORF > 50
        count = count + 1;
    end
end
probability = (count/1000);
%part 4: copy your code from part 3 but put it inside yet another loop,
% this time over the sequence length N. Plot the probability of having an
% ORF > 50 b.p. as a funciton of the sequence length.
seqlen = 500;
plotpoints = 1:seqlen;

for N = 1:seqlen
count = 0;
    for k = 1:1000
        nuc = {'A','T','G','C'};
        rand_numseq = randi([1 4],[1,N]);
        rand_seq = "";
        for i = 1:N
            rand_seq = rand_seq + string(nuc(rand_numseq(i)));
        end

        ORFS = [];
    %Checking ORFs for generated side
        starts = strfind(rand_seq,"ATG");
        stop1 = strfind(rand_seq,"TAG");
        stop2 = strfind(rand_seq,"TGA");
        stop3 = strfind(rand_seq,"TAA");

        stops = horzcat(stop1,stop2,stop3);

        for i = 1:length(starts)
            ORF = min(stops(starts(i) < stops));
            ORF = ORF - starts(i);
            ORFS = horzcat(ORFS,ORF);
        end
        maxORF = max(ORFS);
        if maxORF > 50
            count = count + 1;
        end
    end
    probs(N) = count/1000;
end
figure;
plot(plotpoints, probs);
%part 5: Make sure your results from part 4 are sensible. What features
% must this curve have (hint: what should be the value when N is small or when
% N is very large? how should the curve change in between?) Make sure your
% plot looks like this. 

% When N is small, the probability should be low. The probability should be
% 0 for N values of less than 50. As the sequence length increases the
% probability should increase. As N increases, the probability should
% eventually plateau at 1. 



%% problem 3 data input/output and simple analysis
%Walter Frank Lenoir

%The file qPCRdata.txt is an actual file that comes from a Roche
%LightCycler qPCR machine. The important columns are the Cp which tells
%you the cycle of amplification and the position which tells you the well
%from the 96 well plate. Each column of the plate has a different gene and
%each row has a different condition. Each gene in done in triplicates so
%columns 1-3 are the same gene, columns 4-6 the same, etc.
%so A1-A3 are gene 1 condition 1, B1-B3 gene 1 condition 2, A4-A6 gene 2
%condition 1, B4-B6 gene2 condition 2 etc. 

% part1: write code to read the Cp data from this file into a vector. You can ignore the last two
% rows with positions beginning with G and H as there were no samples here.
q = 1;
fid = fopen('qPCRdata.txt','r');
line1 = fgetl(fid);

while line1 ~= -1
    line1 = fgetl(fid);
    var1 = strsplit(line1,'\t');
    PCRdat(q,:) = var1([3;5]);
    q = q + 1;
end

PCRdat = PCRdat(2:73,1:2);

platenum = cellfun(@str2num,plate);

% Part 2: transform this vector into an array representing the layout of
% the plate. e.g. a 6 row, 12 column array should that data(1,1) = Cp from
% A1, data(1,2) = Cp from A2, data(2,1) = Cp from B1 etc. 

col = 1;
row = 1;
for i = 1:(length(PCRdat))
    if col > 12
        col = 1;
        row = row + 1;
    end
    plate(row,col) = PCRdat(i,2);
    col = col + 1;
end  

platenum = cellfun(@str2num,plate);

% Part 3. The 4th gene in columns 10 - 12 is known as a normalization gene.
% That is, it's should not change between conditions and it is used to normalize 
% the expression values for the others. For the other three
% genes, compute their normalized expression in all  conditions, normalized to condition 1. 
% In other words, the fold change between these conditions and condition 1. The
% formula for this is 2^[Cp0 - CpX - (CpN0 - CpNX)] where Cp0 is the Cp for
% the gene in the 1st condition, CpX is the value of Cp in condition X and
% CpN0 and CpNX are the same quantitites for the normalization gene.
% Plot this data in an appropriate way. 

for i = 2:6
    for j = 1:9
    normalized(i-1,j) = power(2,platenum(1,j) - platenum(i,j) - (platenum(1,rem(j,3)+10)) - platenum(i,rem(j,3)+10));
    end
end
figure;
bar(normalized);

%barplot is appropriate representation of the three genes in the three
%conditions. 


%% Challenge problems that extend the above (optional)

% 1. Write a solution to Problem 2 part 2 that doesn't use any loops at
% all. Hint: start by using the built in function bsxfun to make a matrix of all distances
% between start and stop codons. 

% 2. Problem 2, part 4. Use Matlab to compute the exact solution to this
% problem and compare your answer to what you got previously by testing
% many sequences. Plot both on the same set of axes. Hint: to get started 
% think about the following:
% A. How many sequences of length N are there?
% B. How many ways of making an ORF of length N_ORF are there?
% C. For each N_ORF how many ways of position this reading frame in a
% sequence of length N are there?

% 3. Problem 3. Assume that the error in each Cp is the standard deviation
% of the three measurements. Add a section to your code that propogates this
% uncertainty to the final results. Add error bars to your plot. (on
% propagation of error, see, for example:
% https://en.wikipedia.org/wiki/Propagation_of_uncertainty


