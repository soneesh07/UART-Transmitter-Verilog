module uart_tx(
    input clk,
    input reset,
    input start,
    input [7:0]data_in,
    output reg tx,
    output reg busy,
    output reg done
);

localparam IDLE  = 2'b00;
localparam START = 2'b01;
localparam DATA  = 2'b10;
localparam STOP  = 2'b11;

reg [1:0] current;
reg [1:0] next;

wire baud_done;
wire bit_done;
wire tx_bit;
reg load;
reg  shift;

baud_counter bc(
    .clk(clk),
    .reset(reset),
    .enable(current != IDLE),
    .baud_done(baud_done)
);

bit_counter btc(
    .clk(clk),
    .reset(reset),
    .baud_done(baud_done),
    .enable(current ==DATA),
    .bit_done(bit_done)
);

shift_register sr(
    .clk(clk),
    .reset(reset),
    .data_in(data_in),
    .load(load),
    .shift(shift),
    .tx_bit(tx_bit)
);

always @(posedge clk or posedge reset ) begin
    if(reset)
     current <= IDLE;
    else
     current <= next;
end 

always @(*) begin
    load = 1'b0;
    shift = 1'b0;
    next = current;
    case(current) 
    IDLE:
        if(start) begin
           next = START;
           load= 1'b1;
        end
        else begin
           next = IDLE ;
        end   
    START:
        if(baud_done) begin
            next = DATA;
        end 
        else begin
            next = START;
        end
    DATA :
        if(baud_done) begin
            shift = 1'b1;
            if(bit_done) begin
                next = STOP ;
            end
            else begin
                next = DATA;
            end
        end
        else begin
            next = DATA;
        end 
    STOP :
        if(baud_done) begin
            next = IDLE ;
        end
        else begin
            next = STOP;
        end
    endcase
end

always @(*) begin
    tx = 1'b1;
    busy = 1'b0;
    done =1'b0;
    case(current)
    IDLE: begin
        tx=1'b1;
        busy=1'b0;
        done=1'b0;
    end

    START: begin
        tx=1'b0;
        busy=1'b1;
        done=1'b0;
    end

    DATA: begin
        tx=tx_bit;
        busy=1'b1;
        done=1'b0;
    end

    STOP: begin
        tx=1'b1;
        busy=1'b0;
        done=baud_done;
    end
    endcase
end
endmodule

module baud_counter(
    input clk,
    input reset,
    input enable,
    output reg baud_done
);
parameter BAUD_COUNT=8;
reg [8:0] baud;
always @(posedge clk or posedge reset) begin
    if(reset) begin
        baud <= 0;
        baud_done<=0;
    end 
    else begin
        if(enable) begin
            if (baud == BAUD_COUNT -1) begin
                baud <= 0;
                baud_done<=1;
            end
            else begin
                baud<=baud+1'b1;
                baud_done<=0;
            end 
        end
        else begin
            baud<=0;
            baud_done<=1'b0;
        end
    end 
end 

endmodule

module bit_counter(
    input clk,
    input reset,
    input baud_done,
    input enable,
    output bit_done
);
reg [2:0] bit_count;
parameter BIT_SIZE = 4'd8;
assign bit_done = (bit_count == BIT_SIZE-1) && baud_done && enable;
always @(posedge clk or posedge reset) begin  
    if(reset) begin
        bit_count<= 1'b0; 
    end
    else begin
        if(baud_done && enable) begin
            if(bit_count == BIT_SIZE-1'b1) begin
                bit_count <=1'b0;
            end
            else
                bit_count<= bit_count + 1'b1;
        end
        else begin
            if(!enable) begin
                bit_count<=0;
            end
        end
    end
end
endmodule

module shift_register(
    input clk,
    input reset,
    input [7:0] data_in,
    input load,
    input shift,
    output tx_bit
);
reg [7:0] shift_reg;
assign tx_bit = shift_reg[0];
always @(posedge clk or posedge reset) begin
    if(reset) begin
        shift_reg <= 8'b0;
    end
    else begin
        if(load) begin
            shift_reg<=data_in;
        end
        else begin
            if(shift) begin
                shift_reg<=shift_reg>>1;
            end
        end
    end 
end 
endmodule