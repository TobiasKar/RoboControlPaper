function plotterSimple(a)
close all

f=figure();
subplot(1,2,1);

x=inputdlg({'Name'},'input',[1 100]);

subplot(1,2,1);
plot(a(1,:),[a(2,:);a(4,:)],'LineWidth',2);
legend('Joint1 Position','Joint1 Velocity');
ylabel('rad rad/s');
xlabel('Time');
set(gca,'Fontsize',14);
subplot(1,2,2);
plot(a(1,:),[a(3,:);a(5,:)],'LineWidth',2);
legend('Joint2 Position','Joint2 Velocity');
xlabel('Time');
ylabel('rad rad/s');
set(gca,'Fontsize',14);

pos = get(gcf,'Position') ;
set(gcf,'Position',[pos(1) pos(2) pos(3) 1.2*pos(4)]); 

mtit(gcf,x{1});
y=x{1};
y(ismember(y,' ,.:;!')) = [];
[FileName,PathName] = uiputfile('*.png','SAVE',strcat('C:\Users\kargto\Documents\Git\RoboControlPaper\Report\pics','\',y));
saveDataName = fullfile(PathName,FileName);


saveas(f, saveDataName, 'png'); 
saveDataName=saveDataName(1:end-4);
saveas(f, saveDataName,'fig'); 
