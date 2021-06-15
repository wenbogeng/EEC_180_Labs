module add8Bits(a, b, cin, sum, cout, overflow);
	input[7:0] a, b;
	input cin;
	
	output [7:0] sum;
	output cout, overflow;
	
	wire[6:0] c;
	
	
	fullAdder fa0(a[0],b[0],0,sum[0],c[0]);
	fullAdder fa1(a[1],b[1],c[0],sum[1],c[1]);
	fullAdder fa2(a[2],b[2],c[1],sum[2],c[2]);
	fullAdder fa3(a[3],b[3],c[2],sum[3],c[3]);
	fullAdder fa4(a[4],b[4],c[3],sum[4],c[4]);
	fullAdder fa5(a[5],b[5],c[4],sum[5],c[5]);
	fullAdder fa6(a[6],b[6],c[5],sum[6],c[6]);
	fullAdder fa7(a[7],b[7],c[6],sum[7],cout);
	
	assign overflow = (a[7] & b[7]);
	
endmodule