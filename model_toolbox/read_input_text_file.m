%read input text file called model_setup.txt
%set model options, timesteps, and comments

   fileID = fopen('input/model_setup.txt');
   
   options_in = zeros(17,1);
   count = 1;
   for i=1:21
       line = fgetl(fileID);
       %numerical options to turn on off chemistry, diffusion, heterogenous
       %reactions, etc
       if(i>3 && i<20)
           output = textscan(line, '%d', 'CollectOutput', 1);
           options_in(count) = output{1};
           %disp(options_in(count));
           %disp(count);
           %disp('********');
           if ((i>3 && i<16) && (options_in(count) ~= 0 && options_in(count) ~= 1))
               %disp(options_in(count));
               err_msg = 'Value for turning on/off chemistry, diffusion, etc. must be either 0 or 1, fix your model_setup.txt';
               clean_exit('read_input_text_file.m',err_msg);
           end
           count = count+1;
       end
       if(i==20)
           comment1 = line;
       end
       if(i==21) 
           comment2 = line;
       end 
   end
   fclose(fileID);
  
 % run chemistry - yes=1 or no=0
   run_chem = options_in(1); 
 % run vertical diffusion - yes=1 or no=0
   run_vert_diff = options_in(2);
 % run add_emissions - yes=1 or no=0
   addemissions = options_in(3);
 % Initialize surface concentrations - yes=1 or no=0
   initialize_surface_concentrations = options_in(4);
 % Add soil_NO_emissions - yes=1 or no=0
   add_NO_soil_emissions = options_in(5);
 % Add surface HONO source - yes=1 or no=0  
   add_surface_source_HONO  = options_in(6);
 % Add surface HONO source - yes=1 or no=0  
   add_surface_source_Cl_Br  = options_in(7);
 % Add surface HONO source - yes=1 or no=0  
   add_surface_source_Iodine  = options_in(8);
 % global value for including heterogenous chemistry on aerosols - yes=1 or no=0
   global xhet;
   xhet = options_in(9);
 % global value for including Iodine chemistry - yes=1 or no=0
   global xIod;
   xIod = options_in(10);
 % global value for including Chlorine chemistry - yes=1 or no=0
   global xCl;
   xCl = options_in(11);
 % global value for including Bromine chemistry - yes=1 or no=0
   global xBr;
   xBr = options_in(12);
 % global value for including surface loss in model level 1 - yes=1 or no=0
   dt_chem      = options_in(13);                                                    %chemistry timestep in seconds, also output frequency
   dt_kpp       = options_in(14);                                                    %timestep - (smaller than dt_chem) within kpp, seconds
   n_step_diff    = options_in(15);                                                  %timestep - (smaller than dt_chem) within kpp, seconds
   
   % JPS new 8/11/17 -----------------------------------------------------
   global WriteRep;
   WriteRep=options_in(16);
   
   output_file_comment = comment1;
   output_file_created_by = comment2;
   
   %write this back to output file
   fileID = fopen('output/model_setup_out.txt','w');
   fprintf(fileID,'#options for model run\n');
   fprintf(fileID,'%s  \t %d\n','run_chem',run_chem);
   fprintf(fileID,'%s  \t %d\n','run_vert_diff',run_vert_diff);
   fprintf(fileID,'%s  \t %d\n','addemissions',addemissions);
   fprintf(fileID,'%s  \t %d\n','initialize_surface_concentrations',initialize_surface_concentrations);
   fprintf(fileID,'%s  \t %d\n','add_NO_soil_emissions',add_NO_soil_emissions);
   fprintf(fileID,'%s  \t %d\n','add_surface_source_HONO',add_surface_source_HONO);
   fprintf(fileID,'%s  \t %d\n','add_surface_source_Cl_Br',add_surface_source_Cl_Br);
   fprintf(fileID,'%s  \t %d\n','add_surface_source_Iodine',add_surface_source_Iodine);
   fprintf(fileID,'%s    \t %d\n','xhet',xhet);
   fprintf(fileID,'%s    \t %d\n','xIod',xIod);
   fprintf(fileID,'%s    \t %d\n','xCl',xCl);
   fprintf(fileID,'%s    \t %d\n','xBr',xBr);
   fprintf(fileID,'%s  \t %d\n','dt_chem',dt_chem);
   fprintf(fileID,'%s  \t %d\n','dt_kpp',dt_kpp);
   fprintf(fileID,'%s  \t %d\n','n_step_diff',n_step_diff);
   fprintf(fileID,'%s  \t %d\n','Write Repetition',WriteRep);
   fprintf(fileID,'%s  \t %s\n','output_file_comment',output_file_comment);
   fprintf(fileID,'%s \t %s\n','output_file_created_by',output_file_created_by);
   fclose(fileID);
