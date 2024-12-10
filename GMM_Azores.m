

function [lnY,stdinter,stdintra]=GMM_Azores(T,Mw,Rjb,Fdepth)

%%  Ground Motion Model using Simulated Scenario Earthquake Records in Azores Plateau (Portugal) at Bedrock (Ji et al.,2024)
%---Input
% T: period of interest of Sa (scaler), need to be within 2.0s
% M: moment magnitude of the scenario EQ (scaler)
% R_jb: R_jb of target site (scaler)
% COEF: regression coefficients for GMM_Azores
%---Output
% lnY: median IM (ln scale, scaler: PGA and PSA in unit 'g', PGV in unit 'cm/s')
% stdinter: standard deviation of inter-event residual (ln scale, scaler)
% stdintra: standard deviation of intra-event residual (ln scale, scaler)


M1=Mw;
R=Rjb;
Focaldepth=Fdepth;

Mh1=5.5;
Mh2=6.5;
Ttar=[0 0.0200000000000000	0.0300000000000000	0.0500000000000000	0.0700000000000000	0.100000000000000	0.150000000000000	0.200000000000000	0.250000000000000	0.300000000000000	0.350000000000000	0.400000000000000	0.450000000000000	0.500000000000000	0.600000000000000	0.700000000000000	0.800000000000000	1	1.20000000000000	1.50000000000000	2	2.50000000000000	3	4];
COEF=[-4.96708915535545	0.672223287840007	-0.276989292236236	0.0583578621101360	-1.07179692732781	0.172437369807980	-0.0102983602817697	0.236980120274175	0.202708693071518
    -4.91691136987474	0.665702406219193	-0.273901584620427	0.0605481616658419	-1.07384627961283	0.172794337932387	-0.0103167792062967	0.236666343148387	0.204048780957233
    -4.84247071527072	0.656045052943396	-0.269387503570062	0.0637514784760505	-1.07714391865245	0.173385064807256	-0.0103416786253443	0.236203175453200	0.206085682198788
    -4.45275315986674	0.606083224567131	-0.246370388614185	0.0809638304065941	-1.09416637329090	0.176511239134107	-0.0105100858868651	0.233685750300577	0.222456958903459
    -3.90989892704072	0.538881967914159	-0.204327632286716	0.0995181413974921	-1.10101241863761	0.175736108930232	-0.0111333976121632	0.231187002176798	0.247539792076154
    -3.49914531858119	0.498695613156141	-0.164041779914646	0.124546505405421	-1.06629887025290	0.162838097061777	-0.0123511061344311	0.233553349532433	0.269695319566990
    -3.67348114648977	0.549187116624378	-0.156086462359079	0.134667468127294	-0.980415861824312	0.135457334203018	-0.0134260701538668	0.246913754195626	0.265836997352510
    -4.10864446144088	0.628873650363124	-0.192966570576910	0.105548087379453	-0.934983215744768	0.121653783506467	-0.0132111798738809	0.258114275682896	0.246928738497212
    -4.64482340318867	0.717842975729968	-0.239245767027184	0.0651073654174402	-0.906829593473443	0.113080158525795	-0.0126667763853252	0.266968621663372	0.228940816005745
    -5.28257457320302	0.819143571002498	-0.300910403188959	0.0587456536959487	-0.880402182552481	0.107009276627017	-0.0122763510040605	0.274687684359960	0.213929103917908
    -6.02152052624861	0.937338845778299	-0.376004509278418	0.0317596092298837	-0.857363974587456	0.100782016812873	-0.0118689104958076	0.284254976498577	0.201202250962606
    -6.66549023454421	1.03952030692445	-0.442330566774180	0.0146673627378387	-0.850006054688467	0.0978647125161091	-0.0113097521558465	0.291433660541297	0.191067066722068
    -7.28218091506534	1.13740137002579	-0.508944125647674	-0.0238083594104635	-0.850969239627741	0.0979542540656805	-0.0107360514461984	0.297197771526406	0.182862123380182
    -7.93428573560860	1.24010022319132	-0.575018903630375	-0.0502044021087550	-0.846507362263441	0.0959969379819393	-0.0102499795018604	0.302612100290133	0.176204970669932
    -9.23413155490809	1.44135986348444	-0.694648821509520	-0.132349841730783	-0.825671684823805	0.0917769077069652	-0.00972057708163194	0.314617837085380	0.164567266286304
    -10.4125065894592	1.62241030605266	-0.792591989468677	-0.203513090173950	-0.810179344624905	0.0873459944989140	-0.00920818873012090	0.324868795928303	0.155706803625198
    -11.4453648185030	1.77889114331285	-0.876639342886565	-0.279205434676468	-0.803740322759807	0.0878443206257868	-0.00880985954996364	0.331605869197641	0.148982477692131
    -13.2362994875980	2.04373068911682	-0.986491725618872	-0.420380600575133	-0.789381409273985	0.0844125861503426	-0.00793418504865400	0.345743966865382	0.136307103672930
    -14.6136068664800	2.23747462034880	-1.03237584676630	-0.562563541931038	-0.776611962218868	0.0812229193351992	-0.00726086985087434	0.355989586022079	0.124440075160368
    -16.0795885581007	2.42842315723775	-1.04366211115078	-0.725170260681383	-0.772335684911641	0.0836960716206892	-0.00630440163561198	0.368150858891495	0.111468233004069
    -17.5070035971010	2.57756165408822	-0.956026569513148	-0.873242813885683	-0.777730534887090	0.0918622817211007	-0.00469142115446361	0.384725951835023	0.103789691706469
    -18.4113176221174	2.64997760869579	-0.862446196989016	-0.881527588732902	-0.788854448235472	0.0995646573169405	-0.00333285447705191	0.395228339156854	0.101102383653251
    -18.7690990609193	2.63671859844353	-0.737764218719865	-0.819530406582306	-0.802873793348393	0.109303960206381	-0.00248789839985708	0.399257643516076	0.101271043694488
    -18.8048676186723	2.52038298090437	-0.516102686272828	-0.601695335234970	-0.842687684867223	0.130973662786576	-0.00122650853926933	0.400096989113447	0.104030327193461
    -3.32010242991311	1.12745819943232	-0.373893613834902	-0.112943647344538	-1.07977779174574	0.233118785856743	-0.00657639934690607	0.275714874417806	0.123356264698372]

if T==0
coef_a=COEF(1,:);
elseif T==-1
coef_a=COEF(end,:);
elseif T>0 & T<=2.0
    for i=1:9
        coef_a(1,i)=interp1(Ttar(1:21),COEF(1:21,i),T);
    end
end

i=1
if M1<Mh1
    fmag(i,1)=coef_a(2)*(M1)+coef_a(1);
    fdis(i,1)=(coef_a(5)+coef_a(6)*(M1-4.5)).*log(sqrt(R(i).^2+3^2))+coef_a(7)*sqrt(R(i).^2+Focaldepth(i).^2);
elseif M1>=Mh1 && M1<Mh2
    fmag(i,1)=coef_a(3)*(M1-Mh1)+coef_a(2)*(M1)+coef_a(1);
    fdis(i,1)=(coef_a(5)+coef_a(6)*(M1-4.5)).*log(sqrt(R(i).^2+3^2))+coef_a(7)*sqrt(R(i).^2+Focaldepth(i).^2);
elseif M1>=Mh2
    fmag(i,1)=coef_a(4)*(M1-Mh2)+coef_a(3)*(M1-Mh1)+coef_a(2)*(M1)+coef_a(1);
    fdis(i,1)=(coef_a(5)+coef_a(6)*(M1-4.5)).*log(sqrt(R(i).^2+3^2))+coef_a(7)*sqrt(R(i).^2+Focaldepth(i).^2);
end
lnY=fmag+fdis;
stdinter=coef_a(8)
stdintra=coef_a(9)
