% FNDER   �֐��̔���
%
% FNDER(F) �́AF(����сA�����^�̊֐�)�Ɋ܂܂���ϐ��֐��̈ꎟ����
% (�̕\��)���o�͂��܂��B
%
% FNDER(F,DORDER) �́AF ��m�ϐ��֐��ł���ꍇ�ɁA[d1,...,dm] �̌`�ł���
% ���Ƃ��v������� DORDER ���g���āADORDER�K�̔������o�͂��܂��B�����ŁA
% �e i=1,..,m �ɂ��āAdi �� F �ɂ���֐���i�Ԗڂ̕ϐ��Ɋւ���di�K����
% ����邱�Ƃ����������ł��B
% �����ŁAdi �����ɂȂ�ƁAi�Ԗڂ̈����Ɋւ���di�K�̐ϕ��ɂȂ�܂��B
%
% FNDER(...) �́A�L���X�v���C���ɑ΂��Ă͋@�\���܂���B����� FNTLR��
% �g�p���Ă��������B
%
% FNDER(...) �́A���Ɍ���ꂽ���@�ɂ���Ă̂݁Ast-�^�̊֐��ɑ΂���
% �@�\���܂��B���Ȃ킿�A�^�C�v tp00 �ɑ΂��Ă̂ݍ�p���A���̏ꍇ�A
% DORDER �́A[1 0]�A���邢�� [0 1] �̂݉\�ł��B
%
% ���:
%
%      fnval( fnder( sp, 2), 3.14 );
% �́Asp �ɂ���֐���3.14�ł̒l��^���܂��B����A
%
%      sp0 = fnint( fnder( sp ) );
% �́A(���Ȃ킿0�̒l�ł�)�������̒萔�݂̂ɂ�� sp �ƈقȂ�֐���
% �^���܂��B
%
% �Q�l : FNDIR, FNTLR, FNINT.


%   Copyright 1987-2003 C. de Boor and The MathWorks, Inc.