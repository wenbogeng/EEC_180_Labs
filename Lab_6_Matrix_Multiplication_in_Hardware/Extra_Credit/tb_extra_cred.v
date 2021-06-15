`timescale 1ns/10ps

// Test bench module
module tb_extra_cred;

// Input Array
/////////////////////////////////////////////////////////
//                  Test Bench Signals                 //
/////////////////////////////////////////////////////////

reg clk;
integer counter,i,j,k;

// Matrices
reg signed [7:0] matrixV [63:0];
reg unsigned [3:0] matrixCol [63:0];
reg unsigned [6:0] matrixRow [16:0];
reg signed [7:0] matrixB [15:0];
reg signed [18:0] matrixC [15:0];

// Comparison Flag
reg comparison;

/////////////////////////////////////////////////////////
//                  I/O Declarations                   //
/////////////////////////////////////////////////////////
// declare variables to hold signals going into submodule
reg start;
reg reset;


// Misc "wires"
wire done;
wire [10:0] clock_count;

/////////////////////////////////////////////////////////
//              Submodule Instantiation                //
/////////////////////////////////////////////////////////

/*****************************************
|------|    RENAME TO MATCH YOUR MODULE */
SpMV DUT
(
    .clk   (clk),
    .start (start),
    .reset (reset),
    .done       (done),
    .clock_count (clock_count)
  );

initial begin

  //****************************************************
  // CHANGE .TXT FILE NAMES TO MATCH THE ONES USED IN
  // YOUR MEMORY MODULES

  // Initialize Matrices
  $readmemb("V.txt", matrixV);
  $readmemb("COL_INDEX.txt", matrixCol);
  $readmemb("ROW_INDEX.txt", matrixRow);
  $readmemb("B.txt", matrixB);

  //***************************************************

  /////////////////////////////////////////////////////////
  //                    Perform Test                     //
  /////////////////////////////////////////////////////////

  ////////////
  // PART 1 //
  ////////////
  // Initialize Module

  reset <= 1'b1;    // Assert Reset
  start <= 1'b0;
  clk <= 1'b0;      // Start Clock
  repeat(2) @(posedge clk); // Wait 2 clock cycles
  reset <= 1'b0;
  repeat(2) @(posedge clk); // Wait 2 clock cycles
  start <= 1'b1;
  repeat(1) @(posedge clk); // Wait 1 clock cycle
  start <= 1'b0;

  ////////////
  // PART 2 //
  ////////////

  // ------------------------
  // Wait for done or timeout
  fork : wait_or_timeout
  begin
    repeat(2000) @(posedge clk);
    disable wait_or_timeout;
  end
  begin
    @(posedge done);
    disable wait_or_timeout;
  end
  join
  // End Timeout Routing
  //-------------------------

  /////////////////////////////////////////////////////////
  //                Verify Computation                   //
  /////////////////////////////////////////////////////////

  ////////////
  // PART 3 //
  ////////////

  // Print Input Matrices
  $display("Matrix A");
  counter = 0;
  for(i=0;i<16;i=i+1) begin
	for(j = 0; j < 16; j = j + 1) begin
		if (matrixCol[counter] == j && counter / 4 == i) begin
			$write(matrixV[counter]);
			$write(", ");
			counter = counter + 1;
		end
		else begin
			$write("   0, ");
		end
	end
	$write("\n");
  end
  
  $display("\n Matrix B");
    for(i=0;i<16;i=i+1) begin
    $display(matrixB[i]);
  end

  // Generate Expected Result
  for(i=0;i<16;i=i+1) begin
    matrixC[i] = 0;
  end
  for(i = 0; i < 16; i = i + 1) begin
		for(j = matrixRow[i]; j < matrixRow[i + 1]; j = j + 1) begin
			matrixC[i] = matrixC[i] + matrixV[j]*matrixB[matrixCol[j]];
		end
  end
  

  // Display Expected Result
  $display("\nExpected Result");
  for(i=0;i<16;i=i+1) begin
    $display(matrixC[i]);
  end

  // Display Output Matrix
  $display("\nGenerated Result");
  for(i=0;i<16;i=i+1) begin
    $display(DUT.RAMOUTPUT.mem[i]);
  end

  ////////////
  // PART 4 //
  ////////////
  
  // Test if the two matrices match
  comparison = 1'b0;
  for(i=0;i<16;i=i+1) begin
    if (matrixC[i] != DUT.RAMOUTPUT.mem[i]) begin
        $display("Mismatch at indices [%1.1d,%1.1d]",j,i);
        comparison = 1'b1;
      end
  end
  if (comparison == 1'b0) begin
    $display("\nsuccess :)");
  end

  $display("Running Time = %d clock cycles",clock_count);

  $stop; // End Simulation
end


// Clock
always begin
   #10;           // wait for initial block to initialize clock
   clk = ~clk;
end

endmodule
