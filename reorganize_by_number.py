#!/usr/bin/env python3
"""
프로그램 이름에서 번호를 추출하여 올바른 번호 폴더로 이동시킵니다.
예: zedr018_001 -> 18번 폴더로 이동
"""
import os
import shutil
import re
from pathlib import Path

def extract_number_from_name(name):
    """프로그램 이름에서 번호를 추출합니다.
    
    예:
    - zedr018_001 -> 18
    - zedr01_001 -> 1
    - zedr02_001 -> 2
    - zed01_calculate -> 1
    - zmm01_001 -> 1
    """
    # zedr, zed, zmm, zwork, zpro 등으로 시작하는 패턴
    patterns = [
        r'zedr(\d+)',      # zedr018_001 -> 018
        r'zed(\d+)',       # zed01_calculate -> 01
        r'zmm(\d+)',       # zmm01_001 -> 01
        r'zwork(\d+)',     # zwork01_001 -> 01
        r'zpro(\d+)',      # zpro07_001 -> 07
        r'zmmr(\d+)',      # zmmr01_001 -> 01
        r'ztest(\d+)',     # ztest01_003 -> 01
        r'zdtp_massdownload(\d+)',  # zdtp_massdownload02 -> 02
        r'zclass_event(\d+)',       # zclass_event10 -> 10
        r'zcustom_container(\d+)',   # zcustom_container10 -> 10
        r'zdocking_container(\d+)',  # zdocking_container10 -> 10
        r'zsplitter_container(\d+)', # zsplitter_container10 -> 10
        r'zproject(\d+)',  # zproject17_001 -> 17
        r'zdel(\d+)',      # zdel11 -> 11
        r'zdown_(\d+)',    # zdown_25 -> 25
        r'z_mass_abap_download_(\d+)',  # z_mass_abap_download_15 -> 15
    ]
    
    for pattern in patterns:
        match = re.search(pattern, name, re.IGNORECASE)
        if match:
            num_str = match.group(1)
            # 018 -> 18, 01 -> 1로 변환
            return int(num_str)
    
    return None

def reorganize_programs(base_path):
    """모든 번호 폴더의 program 폴더에서 프로그램들을 올바른 번호 폴더로 이동"""
    base = Path(base_path)
    
    # 번호 폴더 찾기 (00, 01, 02, ...)
    number_folders = sorted([d for d in base.iterdir() if d.is_dir() and d.name.isdigit()])
    
    # 모든 프로그램 폴더를 수집
    programs_to_move = []
    
    for num_folder in number_folders:
        program_folder = num_folder / "program"
        if not program_folder.exists():
            continue
            
        print(f"\n{num_folder.name}/program 폴더 스캔 중...")
        
        for item in program_folder.iterdir():
            if item.is_dir():
                folder_name = item.name
                target_number = extract_number_from_name(folder_name)
                
                if target_number is not None:
                    current_number = int(num_folder.name)
                    if target_number != current_number:
                        programs_to_move.append({
                            'source': item,
                            'target_number': target_number,
                            'current_number': current_number,
                            'name': folder_name
                        })
    
    # 이동 실행
    print(f"\n총 {len(programs_to_move)}개의 폴더를 이동합니다.")
    
    for prog in programs_to_move:
        source = prog['source']
        target_num = prog['target_number']
        target_folder = base / f"{target_num:02d}" / "program"
        
        # target 폴더가 없으면 생성
        target_folder.mkdir(parents=True, exist_ok=True)
        
        dest = target_folder / source.name
        
        if dest.exists():
            print(f"  경고: {source.name}은(는) 이미 {target_num:02d}/program에 존재합니다. 건너뜁니다.")
        else:
            print(f"  이동: {prog['current_number']:02d}/program/{source.name} -> {target_num:02d}/program/{source.name}")
            shutil.move(str(source), str(dest))

if __name__ == "__main__":
    script_dir = Path(__file__).parent
    reorganize_programs(script_dir)
    print("\n완료되었습니다!")

