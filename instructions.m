function instructions(h)
    fontSize=16;
    % setting messege information to explain the experiment process
    instr_msg = 'Welcome!';
    instr_msg= [instr_msg newline 'In this experiment, stimuli will appear on the screen.'];
    instr_msg= [instr_msg newline 'there will appear randomly in different shapes ("x","o")'];
    instr_msg= [instr_msg newline 'and different colors (red, blue).'];
    instr_msg= [instr_msg newline 'Sometimes one target stimulus will appear, which will be different'];
    instr_msg= [instr_msg newline 'from all the others distractors'];
    instr_msg= [instr_msg newline 'When you notice such stimulus, please press the A key on your keyboard'];
    instr_msg= [instr_msg newline 'When all the stimuli are identical, which means there is no target stimulus,'];     
    instr_msg= [instr_msg newline 'please press the L key on your keyboard'];
    instr_msg= [instr_msg newline 'Try to be as fast and precise as you can.'];
    instr_msg= [instr_msg newline 'Good Luck!'];
    text(0.2,0.5,instr_msg,'fontsize',fontSize, 'color', 'g')
    % getting approval from participant to continue
    pause()
    key = get(h,'CurrentCharacter');
    while ~strcmpi(key,' ') % if other key was pressed
        pause()
        key = get(h,'CurrentCharacter');
    end
    clf(h);
end