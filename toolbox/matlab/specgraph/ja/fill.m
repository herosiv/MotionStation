% FILL   2�����̑��p�`�̓h��Ԃ�
% 
% FILL(X,Y,C )�́A�x�N�g�� X �� Y �Œ�`�����2�����̑��p�`���AC �Ŏw��
% �����J���[�œh��Ԃ��܂��B���p�`�̒��_�́AX �� Y �̗v�f�̑g�Ŏw��
% ����܂��B�K�v�ȏꍇ�A���p�`�͍Ō�̒��_���ŏ��̒��_�ɐڑ����đ��p�`��
% ���܂��B
%
% C �����X�g 'r','g','b','c','m','y','w','k' ����I�����ꂽ�P��̃L����
% �N�^������A�܂��́ARGB�̍s�x�N�g����3�v�f[r g b]�̂Ƃ��A���p�`�͂����
% �̎w�肵���J���[�œh��Ԃ���܂��B
%
% C �� X �� Y �Ɠ��������̃x�N�g���̏ꍇ�A���̗v�f�� CAXIS �ɂ���ăX�P�[
% �����O����A���_�̃J���[���w�肷�邽�߂ɃJ�����g��COLORMAP�ɑ΂���C��
% �f�b�N�X�Ƃ��Ďg�p����܂��B���p�`���̃J���[�́A���_�̃J���[����`���
% ���ē����܂��B
% 
% X �� Y �������T�C�Y�̍s��̏ꍇ�A1��ɑ΂��āA1�̑��p�`���`�悳��܂��B
% ���̏ꍇ�AX ��"flat(���R)"�ȑ��p�`�̃J���[�ɑ΂��Ă͍s�x�N�g���ŁA
% "interpolated(��Ԃ��ꂽ)"���p�`�̃J���[�ɑ΂��Ă͍s��ł��B
%
% X �� Y �̂����ꂩ���s��̏ꍇ�A��������͍s���Ɠ��������̗�x�N�g���ŁA
% ��x�N�g���̈����́A�K�v�ȃT�C�Y�̍s����쐬���邽�߂ɕ��ʂ���܂��B
%
% FILL(X1,Y1,C1,X2,Y2,C2,...) �́A�h��Ԃ��̈�𕡐��A�w�肷����@�ł��B
%
% FILL �́A�s�� C �̒l�ɂ��APATCH�I�u�W�F�N�g�� FaceColor �v���p�e�B��
% 'flat'�A'interp'�A�܂��� colorspec �ɐݒ肵�܂��B
%
% H = FILL(...) �́APATCH�I�u�W�F�N�g�̃n���h���ԍ�����Ȃ��x�N�g����
% �o�͂��܂��BPATCH����1�̃n���h���ԍ��������܂��BX,Y,C ��3�v�f�̌�ɁA
% patch�̃v���p�e�B���w�肷�邽�߂ɁA�p�����[�^�ƒl�̑g���킹���g�����Ƃ�
% �ł��܂��B
% 
% �Q�l�FPATCH, FILL3, COLORMAP, SHADING.


%   Copyright 1984-2002 The MathWorks, Inc. 
%   $Revision: 1.9.4.1 $  $Date: 2004/04/28 02:05:08 $
%   Built-in function.